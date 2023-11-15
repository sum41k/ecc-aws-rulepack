resource "aws_ebs_volume" "this" {
  availability_zone = data.aws_availability_zones.this.names[0]
  size              = 8
  type              = "io1"
  iops              = 100
  tags              = {
     Name = "570-ebs_volume-red" 
  }
}

data "aws_availability_zones" "this" {
  state = "available"
}