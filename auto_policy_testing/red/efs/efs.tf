resource "aws_efs_file_system" "this" {
  creation_token         = "${module.naming.resource_prefix.efs}"
  encrypted              = false
  availability_zone_name = data.aws_availability_zones.this.names[0]
  provider               = aws.provider2
}

resource "aws_efs_backup_policy" "policy" {
  file_system_id = aws_efs_file_system.this.id
  provider       = aws.provider2

  backup_policy {
    status = "DISABLED"
  }
}
