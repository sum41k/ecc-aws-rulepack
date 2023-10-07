resource "aws_lb" "this" {
  name               = "alb-869-green"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.this.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  internal           = true
}
