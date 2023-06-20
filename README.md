# aws-capci-mgn-lab-onprem

#### Table of Contents
1. [Usage](#usage)
2. [Requirements](#requirements)
3. [Providers](#Providers)
4. [Inputs](#inputs)
5. [Outputs](#outputs)
## Usage
*various commands
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_on_prem_vpc"></a> [on\_prem\_vpc](#module\_on\_prem\_vpc) | terraform-aws-modules/vpc/aws | 4.0.2 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.web_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_iam_instance_profile.ec2_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ec2_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.webserver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_network_interface.web_nic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_security_group.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_foo"></a> [foo](#input\_foo) | n/a | `bool` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type | `string` | n/a | yes |
| <a name="input_mysql_root_password"></a> [mysql\_root\_password](#input\_mysql\_root\_password) | MySQL root password | `string` | n/a | yes |
| <a name="input_number_of_azs"></a> [number\_of\_azs](#input\_number\_of\_azs) | Required number of Availibility Zones | `number` | n/a | yes |
| <a name="input_on_prem_vpc_cidr"></a> [on\_prem\_vpc\_cidr](#input\_on\_prem\_vpc\_cidr) | On-premises VPC cidr | `string` | n/a | yes |
| <a name="input_on_prem_vpc_name"></a> [on\_prem\_vpc\_name](#input\_on\_prem\_vpc\_name) | On-premises VPC name | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region to work with | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the resources | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_on_prem_vpc_id"></a> [on\_prem\_vpc\_id](#output\_on\_prem\_vpc\_id) | n/a |
| <a name="output_onprem_app_elastic_ip"></a> [onprem\_app\_elastic\_ip](#output\_onprem\_app\_elastic\_ip) | n/a |
| <a name="output_onprem_app_private_ip"></a> [onprem\_app\_private\_ip](#output\_onprem\_app\_private\_ip) | n/a |
| <a name="output_onprem_db_private_ip"></a> [onprem\_db\_private\_ip](#output\_onprem\_db\_private\_ip) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->