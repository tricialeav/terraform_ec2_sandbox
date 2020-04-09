provider "aws" {
  version = "~> 2.0"
  region  = var.region
  profile = var.profile
}

data "http" "get_public_ip" {
  url = "http://icanhazip.com"
}

module "ec2_sandbox" {
  source                     = "./modules"
  vpc_cidr_block             = "10.0.0.0/24"
  private_subnet_cidr_blocks = ["10.0.0.0/26", "10.0.0.64/26"]
  public_subnet_cidr_blocks  = ["10.0.0.128/26", "10.0.0.192/26"]
  availability_zone          = var.availability_zone
  sg_cidr_blocks             = [join("", [trimspace(data.http.get_public_ip.body), "/32"])]

  tags = {
    Name = "EC2 Sandbox"
  }
}

