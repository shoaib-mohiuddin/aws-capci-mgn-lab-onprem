output "on_prem_vpc_id" {
  value = module.on_prem_vpc.vpc_id
}

output "onprem_db_private_ip" {
  value = aws_instance.database.private_ip
}

output "onprem_app_private_ip" {
  value = aws_network_interface.web_nic.private_ip
}

output "onprem_app_elastic_ip" {
  value = aws_eip.web_eip.public_ip
}
