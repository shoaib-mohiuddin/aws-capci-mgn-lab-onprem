# On-premises VPC
locals {

  availability_zones              = slice(data.aws_availability_zones.available.names, 0, var.number_of_azs)
  on_prem_public_subnet_cidr      = cidrsubnet(var.on_prem_vpc_cidr, 1, 0)
  on_prem_private_subnet_cidr     = cidrsubnet(var.on_prem_vpc_cidr, 1, 1)
  on_prem_application_subnet_cidr = cidrsubnet(local.on_prem_private_subnet_cidr, 2, 0)
  on_prem_database_subnet_cidr    = cidrsubnet(local.on_prem_private_subnet_cidr, 2, 1)

}