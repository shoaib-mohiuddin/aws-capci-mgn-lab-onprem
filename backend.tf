terraform {
  backend "s3" {
    bucket         = "capci-mgn-lab-tfstates"
    key            = "capci-mgn-lab/on-prem-vpc/terraform.tfstates"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock-capci-mgn-lab"
  }
}