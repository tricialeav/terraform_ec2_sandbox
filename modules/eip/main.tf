resource "aws_eip" "eip" {
  count      = length(var.public_instances)
  vpc        = var.vpc
  instance   = var.public_instances[count.index]
  depends_on = [var.dependency]
}