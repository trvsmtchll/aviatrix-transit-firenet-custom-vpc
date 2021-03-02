// Modify values below as needed
# Aviatrix Controller
#controller_ip = "REPLACE_ME"
#username      = "REPLACE_ME"
#password      = "REPLACE_ME"
#account       = "YOUR AWS ACCOUNT NAME IN AWS"

transit_gw_instance_size = "c5n.4xlarge"
fw_instance_size         = "c5.xlarge"
fw_image                 = "Palo Alto Networks VM-Series Next-Generation Firewall (BYOL)"
fw_version               = "9.1.6"
transit_cidr             = "10.1.0.0/20"

vpcs = {
  vpc1 = {
    name          = "edge-vpc"
    cidr          = "10.0.0.0/16"
    private_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
    public_cidrs  = ["10.0.101.0/24", "10.0.102.0/24"]
  }
  vpc2 = {
    name          = "app1-vpc"
    cidr          = "10.10.0.0/16"
    private_cidrs = ["10.10.1.0/24", "10.10.2.0/24"]
    public_cidrs  = ["10.10.101.0/24", "10.10.102.0/24"]
  }
  vpc3 = {
    name          = "app2-vpc"
    cidr          = "10.20.0.0/16"
    private_cidrs = ["10.20.1.0/24", "10.20.2.0/24"]
    public_cidrs  = ["10.20.101.0/24", "10.20.102.0/24"]
  }
  # and so on..
}
