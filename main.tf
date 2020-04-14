provider "aws" {
  version = "~> 2.0"
  region  = var.region
  profile = var.profile
}

data "http" "get_public_ip" {
  url = "http://icanhazip.com"
}

resource "aws_key_pair" "instance_key_pair" {
  key_name   = "ec2_sandbox"
  public_key = file(var.key_name)
}

module "ec2_sandbox" {
  source                     = "./modules"
  vpc_cidr_block             = "10.0.0.0/16"
  public_subnet_cidr_blocks  = ["10.0.0.0/18"]
  private_subnet_cidr_blocks = ["10.0.64.0/18"]
  public_internet_cidr       = "0.0.0.0/0"
  ipv6_public_internet_cidr = "::/0"
  public_tags = {
    Type = "Public"
  }
  private_tags = {
    Type = "Private"
  }
  availability_zone = var.availability_zone
  private_ip        = join("", [trimspace(data.http.get_public_ip.body), "/32"])
  ami               = "ami-0d6621c01e8c2de2c"
  key_name          = aws_key_pair.instance_key_pair.key_name
  instance_type     = "t2.micro"

  tags = {
    Name = "EC2 Sandbox"
  }
}

