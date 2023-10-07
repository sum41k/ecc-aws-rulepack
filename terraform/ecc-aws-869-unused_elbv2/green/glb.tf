resource "aws_lb" "glb" {
  name               = "glb-869-green"
  internal           = true
  load_balancer_type = "gateway"
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}
