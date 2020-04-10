module "vpc" {
  source         = "./vpc"
  vpc_cidr_block = var.vpc_cidr_block
  tags           = var.tags
}

module "subnets" {
  source                     = "./subnets"
  vpc_id                     = module.vpc.vpc_id
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  availability_zone          = var.availability_zone
  tags                       = var.tags
}

module "security_groups" {
  source                    = "./security_groups"
  vpc_id                    = module.vpc.vpc_id
  private_ip                = var.private_ip
  public_subnet_cidr_blocks = var.public_subnet_cidr_blocks
  tags                      = var.tags
}

module "igw" {
  source = "./internet_gw"
  vpc_id = module.vpc.vpc_id
  tags   = var.tags
}

module "network_acl" {
  source     = "./network_acl"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.subnets.private_subnet_ids
  egress = [
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = var.vpc_cidr_block
      from_port  = 443
      to_port    = 443
    },
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = var.private_ip
      from_port  = 22
      to_port    = 22
    }
  ]
  ingress = [
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = var.vpc_cidr_block
      from_port  = 443
      to_port    = 443
    },
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = var.private_ip
      from_port  = 22
      to_port    = 22
    }
  ]
  tags = var.tags
}

module "ec2_private_instances" {
  source                 = "./private_ec2"
  ami                    = var.ami
  key_name               = var.key_name
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  vpc_security_group_ids = [module.security_groups.sg_all_instances, module.security_groups.sg_private_instances]
  private_subnet_ids     = module.subnets.private_subnet_ids
  tags                   = var.tags
}

module "ec2_public_instances" {
  source                 = "./public_ec2"
  ami                    = var.ami
  key_name               = var.key_name
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  vpc_security_group_ids = [module.security_groups.sg_all_instances, module.security_groups.sg_public_instances]
  public_subnet_ids      = module.subnets.public_subnet_ids
  tags                   = var.tags
}