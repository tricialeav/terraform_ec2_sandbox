provider "aws" {
  version = "~> 2.0"
  region  = "us-west-2"
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
  source                    = "./modules"
  vpc_cidr_block            = "10.0.0.0/16"
  public_internet_cidr      = "0.0.0.0/0"
  ipv6_public_internet_cidr = "::/0"
  public_tags = {
    Type = "Public"
  }
  private_tags = {
    Type = "Private"
  }
  availability_zones = ["us-west-2a", "us-west-2b"]
  private_ip         = join("", [trimspace(data.http.get_public_ip.body), "/32"])
  ami                = "ami-0d6621c01e8c2de2c"
  key_name           = aws_key_pair.instance_key_pair.key_name
  instance_type      = "t2.micro"

  tags = {
    Name = "EC2 Sandbox"
  }
}

