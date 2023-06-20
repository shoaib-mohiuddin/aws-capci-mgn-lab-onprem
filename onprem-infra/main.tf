# Source VPC module
module "on_prem_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"

  name = var.on_prem_vpc_name
  cidr = var.on_prem_vpc_cidr
  azs  = slice(data.aws_availability_zones.available.names, 0, var.number_of_azs)

  public_subnets   = [for i, v in local.availability_zones : cidrsubnet(local.on_prem_public_subnet_cidr, 3, i)]
  private_subnets  = [for i, v in local.availability_zones : cidrsubnet(local.on_prem_application_subnet_cidr, 2, i)]
  database_subnets = [for i, v in local.availability_zones : cidrsubnet(local.on_prem_database_subnet_cidr, 2, i)]

  create_database_subnet_group = false
  enable_nat_gateway           = true
  single_nat_gateway           = true
  one_nat_gateway_per_az       = false
  enable_dns_hostnames         = true
  enable_dns_support           = true

  tags = var.tags

}

# # EC2 instances for on-prem web and database servers
resource "aws_instance" "webserver" {
  # checkov:skip=CKV_AWS_8: ADD REASON: ebs encryption
  # checkov:skip=CKV_AWS_135: ADD REASON: ebs optimized
  # checkov:skip=CKV_AWS_126: ADD REASON: detailed monitoring
  # checkov:skip=CKV_AWS_79: ADD REASON: instance metadata service
  depends_on    = [aws_network_interface.web_nic, aws_instance.database]
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  # subnet_id              = module.on_prem_vpc.public_subnets[0]
  # vpc_security_group_ids = [aws_security_group.web.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  network_interface {
    network_interface_id = aws_network_interface.web_nic.id
    device_index         = 0
  }
  user_data = templatefile("${path.module}/scripts/web_userdata.sh.tpl", {
    db_private_ip       = aws_instance.database.private_ip
    mysql_root_password = var.mysql_root_password
  })
  tags = {
    "Name" = "on-prem-webserver"
  }

}

resource "aws_network_interface" "web_nic" {
  subnet_id       = module.on_prem_vpc.public_subnets[0]
  security_groups = [aws_security_group.web.id]
  description     = "web-nic"
}

resource "aws_eip" "web_eip" {
  instance = aws_instance.webserver.id
  vpc      = true
  tags     = var.tags
}

resource "aws_instance" "database" {
  # checkov:skip=CKV_AWS_8: ADD REASON: ebs encryption
  # checkov:skip=CKV_AWS_135: ADD REASON: ebs optimized
  # checkov:skip=CKV_AWS_126: ADD REASON: detailed monitoring
  # checkov:skip=CKV_AWS_79: ADD REASON: instance metadata service
  depends_on             = [module.on_prem_vpc.aws_nat_gateway, aws_network_interface.web_nic]
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = module.on_prem_vpc.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.db.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  user_data = templatefile("${path.module}/scripts/db_userdata.sh.tpl", {
    app_private_ip      = aws_network_interface.web_nic.private_ip
    mysql_root_password = var.mysql_root_password
  })
  tags = {
    "Name" = "on-prem-dbserver"
  }

}

# Security groups for on-prem web and database servers
resource "aws_security_group" "web" {
  # checkov:skip=CKV_AWS_260: ADD REASON: open ports to internet
  name        = "web-sg"
  description = "Security group for webserver"
  vpc_id      = module.on_prem_vpc.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "For MGN"
    from_port   = 1500
    to_port     = 1500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" : "web-sg"
  }

}

resource "aws_security_group" "db" {
  # checkov:skip=CKV_AWS_260: ADD REASON: open ports to internet
  name        = "db-sg"
  description = "Security group for database server"
  vpc_id      = module.on_prem_vpc.vpc_id

  ingress {
    description     = "Database"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  ingress {
    description = "For DMS"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" : "db-sg"
  }

}
