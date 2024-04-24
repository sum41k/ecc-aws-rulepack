resource "aws_efs_file_system" "this" {
  provider               = aws.provider2
  creation_token         = "${module.naming.resource_prefix.efs}"
  encrypted              = false
  availability_zone_name = data.aws_availability_zones.this.names[0] 
}

resource "aws_efs_backup_policy" "policy" {
  file_system_id = aws_efs_file_system.this.id

  backup_policy {
    status = "DISABLED"
  }
}
