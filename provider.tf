provider "aws" {
  region  = var.aws_region
  version = "3.30.0"
}

provider "aviatrix" {
  controller_ip           = var.controller_ip
  username                = var.username
  password                = var.password
  skip_version_validation = true
  version                 = "2.18"
}
