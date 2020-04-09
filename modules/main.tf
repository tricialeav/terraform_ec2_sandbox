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
  source         = "./security_groups"
  vpc_id         = module.vpc.vpc_id
  sg_cidr_blocks = var.sg_cidr_blocks
  tags           = var.tags
}