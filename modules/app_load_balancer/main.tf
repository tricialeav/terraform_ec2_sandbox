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

resource "aws_lb_target_group" "target_group" {
  port                          = var.port
  protocol                      = var.protocol
  vpc_id                        = var.vpc_id
  load_balancing_algorithm_type = var.load_balancing_algorithm_type
  target_type                   = var.target_type

    health_check {
        enabled             = true
        interval            = 8
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 2
        unhealthy_threshold = 3
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200-399"
      }
}

resource "aws_lb_target_group_attachment" "alb_tg_attachment" {
  count            = length(var.target_ids)
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.target_ids[count.index]
  port             = var.port
}

resource "aws_lb_listener" "web_servers" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.port
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}