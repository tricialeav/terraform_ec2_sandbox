locals {
  az_count = length(var.availability_zones)
}


resource "aws_subnet" "subnet" {
  count             = local.az_count
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet(var.cidr_blocks, ceil(log(var.total_subnets, 2)), count.index)
  availability_zone = var.availability_zones[count.index]

  tags = var.tags
}