resource "aws_efs_file_system" "this" {
  creation_token = "604_efs_green"
  availability_zone_name = data.aws_availability_zones.this.names[0]
  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }
    lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
    tags = {
    Name = "604_instance_green"
  }
}

data "aws_availability_zones" "this" {}
