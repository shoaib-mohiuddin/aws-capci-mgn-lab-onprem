region              = "us-west-2"
number_of_azs       = 2
on_prem_vpc_name    = "on-prem-vpc"
on_prem_vpc_cidr    = "192.168.0.0/20"
instance_type       = "t2.small"
mysql_root_password = "Abcd1234!"
# checkov:skip=CKV_SECRET_80: ADD REASON
tags = {
  "Project"     = "capci-mgn-lab"
  "Environment" = "Dev"
  "Platform"    = "on-premises"
}
