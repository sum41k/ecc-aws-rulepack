resource "random_password" "this" {
  length           = 12
  special          = true
  numeric          = true
  override_special = "!#$%*()-_=+[]{}:?"
}

resource "aws_db_instance" "mysql" {
  provider                        = aws.provider2
  identifier                      = "${module.naming.resource_prefix.rds_instance}-mysql"
  engine                          = "mysql"
  engine_version                  = data.aws_rds_engine_version.mysql.version_actual
  instance_class                  = "db.t3.micro"
  allocated_storage               = 100
  iops                            = 1000
  storage_type                    = "io1"
  username                        = "admin"
  password                        = random_password.this.result
  multi_az                        = false
  backup_retention_period         = 0
  publicly_accessible             = true
  skip_final_snapshot             = true
  apply_immediately               = true
  delete_automated_backups        = true
  storage_encrypted               = false
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  parameter_group_name            = aws_db_parameter_group.mysql.id
  auto_minor_version_upgrade      = false
}

resource "aws_db_parameter_group" "mysql" {
  name   = "${module.naming.resource_prefix.rds_param_grp}-mysql"
  family = data.aws_rds_engine_version.mysql.parameter_group_family
  parameter {
    name  = "log_output"
    value = "FILE"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "sql_mode"
    value        = "NO_BACKSLASH_ESCAPES"
  }
}

data "aws_rds_engine_version" "mysql" {
  engine  = "mysql"
  latest  = true
  version = "5.7"
}

resource "aws_db_snapshot" "mysql" {
  provider               = aws.provider2
  db_instance_identifier = aws_db_instance.mysql.identifier
  db_snapshot_identifier = "${module.naming.resource_prefix.rds_instance}-mysql"
}

resource "null_resource" "make_public_snap" {
  depends_on = [
    aws_db_instance.mysql
  ]
  triggers = {
    region     = var.region
    identifier = "${module.naming.resource_prefix.rds_instance}-mysql"
  }
  provisioner "local-exec" {
    # interpreter = ["/bin/bash", "-c"]
    command = <<EOF
export AWS_REGION=${self.triggers.region}
while true; do
  status="$(aws rds describe-db-snapshots --db-snapshot-identifier ${self.triggers.identifier} --query DBSnapshots[0].Status --output text)"
  if [ "$status" = "available" ]; then
    aws rds modify-db-snapshot-attribute  --db-snapshot-identifier  ${self.triggers.identifier} --attribute-name restore --values-to-add "all"
    break
  else
    echo "Waiting for snapshot to be available"
    sleep 60
  fi
done
EOF
  }
}