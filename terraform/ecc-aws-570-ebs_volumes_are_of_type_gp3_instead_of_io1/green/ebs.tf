resource "aws_ebs_volume" "this" {
  availability_zone = data.aws_availability_zones.this.names[0]
  size              = 8
  type              = "gp3"
  tags              = {
     Name = "570-ebs_volume-green" 
  }
}

data "aws_availability_zones" "this" {
  state = "available"
}