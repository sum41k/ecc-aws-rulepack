resource "aws_lb" "nlb" {
  name               = "nlb-869-green"
  internal           = true
  load_balancer_type = "network"
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}
