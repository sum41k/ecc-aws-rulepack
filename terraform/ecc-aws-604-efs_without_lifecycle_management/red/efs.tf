resource "aws_efs_file_system" "this" {
  creation_token = "604_efs_red"
  availability_zone_name = data.aws_availability_zones.this.names[0]
    tags = {
    Name = "604_instance_red"
  }
}

data "aws_availability_zones" "this" {}
