resource "aws_subnet" "subnet" {
  for_each          = toset(var.cidr_blocks)
  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = var.availability_zone

  tags = var.tags
}