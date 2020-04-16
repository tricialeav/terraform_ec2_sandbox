module "vpc" {
  source         = "./vpc"
  vpc_cidr_block = var.vpc_cidr_block
  tags           = var.tags
}

module "public_subnets" {
  source             = "./subnets"
  public             = true
  vpc_id             = module.vpc.vpc_id
  cidr_blocks        = cidrsubnet(var.vpc_cidr_block, 2, 1)
  availability_zones = var.availability_zones
  total_subnets      = 2
  tags = {
    Name = "Public Subnet"
  }
}

module "private_subnets" {
  source             = "./subnets"
  public             = false
  vpc_id             = module.vpc.vpc_id
  cidr_blocks        = cidrsubnet(var.vpc_cidr_block, 2, 2)
  availability_zones = var.availability_zones
  total_subnets      = 2
  tags = {
    Name = "Private Subnet"
  }
}

module "security_groups" {
  source     = "./security_groups"
  vpc_id     = module.vpc.vpc_id
  private_ip = var.private_ip
  tags       = var.tags
}

module "igw" {
  source = "./internet_gw"
  vpc_id = module.vpc.vpc_id
  tags   = var.tags
}

module "alb" {
  source          = "./load_balancer"
  name            = "sandbox-load-balancer"
  internal        = true
  security_groups = [module.security_groups.sg_public_instances]
  subnet_ids      = module.public_subnets.subnet_ids
  tags            = var.tags
}

module "public_route_table" {
  source                    = "./route_tables"
  public                    = true
  vpc_id                    = module.vpc.vpc_id
  public_internet_cidr      = var.public_internet_cidr
  ipv6_public_internet_cidr = var.ipv6_public_internet_cidr
  gateway_id                = module.igw.igw_id
  vpc_cidr_block            = var.vpc_cidr_block
  tags                      = var.tags
  rt_tags                   = var.public_tags
  subnet_ids                = module.public_subnets.subnet_ids
}

module "private_route_table" {
  source         = "./route_tables"
  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = var.vpc_cidr_block
  tags           = var.tags
  rt_tags        = var.private_tags
  subnet_ids     = module.private_subnets.subnet_ids
}

module "public_network_acl" {
  source     = "./network_acl"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.public_subnets.subnet_ids
  inbound_nacl_rules = [
    {
      rule_number = 100
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = var.public_internet_cidr
      from_port   = 443
      to_port     = 443
      icmp_type   = null
      icmp_code   = null
    },
    {
      rule_number = 110
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = var.public_internet_cidr
      from_port   = 80
      to_port     = 80
      icmp_type   = null
      icmp_code   = null
    },
    {
      rule_number = 120
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = var.private_ip
      from_port   = 22
      to_port     = 22
      icmp_type   = null
      icmp_code   = null
    },
    {
      rule_number = 130
      protocol    = "icmp"
      rule_action = "allow"
      cidr_block  = var.private_ip
      from_port   = 0
      to_port     = 0
      icmp_type   = "-1"
      icmp_code   = "-1"
    }
  ]

  tags      = var.tags
  nacl_tags = var.public_tags
}

module "private_network_acl" {
  source     = "./network_acl"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.private_subnets.subnet_ids

  inbound_nacl_rules = [
    {
      rule_number = 100
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = var.vpc_cidr_block
      from_port   = 443
      to_port     = 443
      icmp_type   = null
      icmp_code   = null
    },
    {
      rule_number = 110
      protocol    = "tcp"
      rule_action = "allow"
      cidr_block  = var.vpc_cidr_block
      from_port   = 80
      to_port     = 80
      icmp_type   = null
      icmp_code   = null
    }
  ]

  tags      = var.tags
  nacl_tags = var.private_tags
}

module "eip" {
  source           = "./eip"
  public_instances = module.ec2_public_instances.instance_ids
  dependency       = module.igw
}

module "ec2_private_instances" {
  source                 = "./ec2"
  ami                    = var.ami
  key_name               = var.key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = [module.security_groups.sg_private_instances]
  subnet_ids             = module.private_subnets.subnet_ids
  tags                   = var.tags
  ec2_tags = {
    Name = "Private EC2"
  }
}

module "ec2_public_instances" {
  source                 = "./ec2"
  ami                    = var.ami
  key_name               = var.key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = [module.security_groups.sg_public_instances]
  subnet_ids             = module.public_subnets.subnet_ids
  tags                   = var.tags
  ec2_tags = {
    Name = "Public EC2"
  }
}