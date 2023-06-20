variable "region" {
  description = "AWS region to work with"
  type        = string
}

variable "number_of_azs" {
  description = "Required number of Availibility Zones"
  type        = number
}

variable "on_prem_vpc_name" {
  description = "On-premises VPC name"
  type        = string
}

variable "on_prem_vpc_cidr" {
  description = "On-premises VPC cidr"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "mysql_root_password" {
  description = "MySQL root password"
  type        = string
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
}

variable "foo" {
  type = string
}
