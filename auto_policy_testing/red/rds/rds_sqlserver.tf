resource "aws_db_instance" "sqlserver" {
  identifier                      = "${module.naming.resource_prefix.rds_instance}-sqlserver"
  engine                          = "sqlserver-web"
  instance_class                  = "db.t3.small"
  allocated_storage               = 20
  storage_type                    = "gp2"
  username                        = "root"
  password                        = random_password.this.result
  multi_az                        = false
  skip_final_snapshot             = true
  enabled_cloudwatch_logs_exports = ["agent"]
  delete_automated_backups        = true
}