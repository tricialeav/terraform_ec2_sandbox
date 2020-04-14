resource "aws_network_acl" "nacl" {
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  tags = merge(var.tags, var.nacl_tags)
}

resource "aws_network_acl_rule" "inbound" {
  count = length(var.inbound_nacl_rules)

  network_acl_id = aws_network_acl.nacl.id

  egress      = false
  rule_number = var.inbound_nacl_rules[count.index]["rule_number"]
  rule_action = var.inbound_nacl_rules[count.index]["rule_action"]
  from_port   = var.inbound_nacl_rules[count.index]["from_port"]
  to_port     = var.inbound_nacl_rules[count.index]["to_port"]
  protocol    = var.inbound_nacl_rules[count.index]["protocol"]
  icmp_type   = var.inbound_nacl_rules[count.index]["icmp_type"]
  icmp_code   = var.inbound_nacl_rules[count.index]["icmp_code"]
  cidr_block  = var.inbound_nacl_rules[count.index]["cidr_block"]
}