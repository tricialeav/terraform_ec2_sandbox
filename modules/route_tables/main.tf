resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  tags = merge(var.tags, var.rt_tags)
}

resource "aws_route" "public_internet_gateway_ipv4" {
  count                  = var.public ? 1 : 0
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = var.public_internet_cidr
  gateway_id             = var.gateway_id
}

resource "aws_route" "public_internet_gateway_ipv6" {
  count = var.public ? 1 : 0
  route_table_id = aws_route_table.route_table.id
  destination_ipv6_cidr_block = var.ipv6_public_internet_cidr
  gateway_id = var.gateway_id
}

resource "aws_route_table_association" "route_table_association" {
  count          = length(var.subnet_ids)
  subnet_id      = var.subnet_ids[count.index]
  route_table_id = aws_route_table.route_table.id
}