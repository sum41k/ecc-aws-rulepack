resource "aws_lb" "this" {
  name               = module.naming.resource_prefix.lb
  internal           = true
  load_balancer_type = "application"
  subnets = [
    data.terraform_remote_state.common.outputs.vpc_subnet_1_id,
    data.terraform_remote_state.common.outputs.vpc_subnet_3_id
  ]
}

resource "aws_lb_target_group" "this" {
  name     = module.naming.resource_prefix.lb
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.common.outputs.vpc_id
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.this1.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
