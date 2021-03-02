module "vpc" {
  for_each = var.vpcs
  source   = "terraform-aws-modules/vpc/aws"

  name = each.value.name
  cidr = each.value.cidr

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = each.value.private_cidrs
  public_subnets  = each.value.public_cidrs

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    VPC-Purpose = each.value.name
    Aviatrix    = "DO-NOT-DELETE"
  }
}

resource "aviatrix_spoke_gateway" "spoke_gateway" {
  for_each           = var.vpcs
  cloud_type         = 1
  account_name       = var.account
  gw_name            = "${each.value.name}-spoke-gw"
  vpc_id             = module.vpc[each.key].vpc_id
  vpc_reg            = var.aws_region
  gw_size            = var.instance_size
  ha_gw_size         = var.instance_size
  subnet             = module.vpc[each.key].public_subnets_cidr_blocks[0]
  ha_subnet          = module.vpc[each.key].public_subnets_cidr_blocks[1]
  enable_active_mesh = true
  tag_list = [
    "Terraform:true",
    "VPC-Purpose:${each.value.name}",
    "Aviatrix:DO-NOT-DELETE"
  ]
}

resource "aviatrix_spoke_transit_attachment" "default" {
  for_each        = var.vpcs
  spoke_gw_name   = aviatrix_spoke_gateway.spoke_gateway[each.key].gw_name
  transit_gw_name = module.transit_firenet.transit_gateway.gw_name
}

module "transit_firenet" {
  source  = "terraform-aviatrix-modules/aws-transit-firenet/aviatrix"
  version = "3.0.2"

  cidr                   = var.transit_cidr
  region                 = var.aws_region
  account                = var.account
  firewall_image         = var.fw_image
  firewall_image_version = var.fw_version
  fw_instance_size       = var.fw_instance_size
  instance_size          = var.transit_gw_instance_size
  local_as_number        = var.transit_asn
}


