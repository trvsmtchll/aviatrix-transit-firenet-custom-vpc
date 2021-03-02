variable "controller_ip" {}
variable "password" {}
variable "username" {}

variable "aws_region" {
  default = "us-east-1"
}

variable "account" {
  description = "The name of the AWS Access Account in Aviatrix Controller"
  default     = "TM-AWS"
}

variable "instance_size" {
  description = "The size of the Aviatrix Spoke Gateways"
  default     = "t3.medium"
}

variable "vpcs" {
  description = "Name, cidr, private_cidrs, public_cidrs"
  type = map(object({
    name          = string
    cidr          = string
    private_cidrs = list(string)
    public_cidrs  = list(string)
  }))
}

variable "transit_cidr" {
  description = "The cidr of the Aviatrix Transit Gateway"
  default     = ""
}

variable "transit_gw_instance_size" {
  description = "The size of the Aviatrix Transit Gateway"
  default     = "c5n.4xlarge"
}

variable "transit_asn" {
  description = "ASN for Transit"
  default     = "65100"
}

variable "fw_instance_size" {
  description = "The size of the Aviatrix Transit Gateway"
  default     = "c5.xlarge"
}

variable "fw_image" {
  description = "The NGFW image from AWS Marketplace you are subscribed to"
  default     = "Palo Alto Networks VM-Series Next-Generation Firewall (BYOL)"
}

variable "fw_version" {
  description = "The NGFW version"
  default     = "9.1.0"
}



