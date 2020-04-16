resource "aws_lb" "alb" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  #TODO
  #   access_logs {
  #     bucket  = "${aws_s3_bucket.lb_logs.bucket}"
  #     prefix  = "test-lb"
  #     enabled = true
  #   }

  tags = var.tags
}