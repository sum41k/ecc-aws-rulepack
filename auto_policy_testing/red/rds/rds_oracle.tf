resource "aws_db_instance" "oracle-ee" {
  identifier                      = "${module.naming.resource_prefix.rds_instance}-oracle-ee"
  engine                          = "oracle-ee"
  instance_class                  = "db.t3.small"
  allocated_storage               = 10
  storage_type                    = "gp2"
  username                        = "root"
  password                        = random_password.this.result
  multi_az                        = false
  storage_encrypted               = true
  skip_final_snapshot             = true
  enabled_cloudwatch_logs_exports = ["audit", "listener"]
  parameter_group_name            = aws_db_parameter_group.oracle-ee.id
  delete_automated_backups        = true
}


resource "aws_db_parameter_group" "oracle-ee" {
  name   = "${module.naming.resource_prefix.rds_param_grp}-oracle-ee"
  family = data.aws_rds_engine_version.oracle-ee.parameter_group_family
  parameter {
    apply_method = "pending-reboot"
    name         = "audit_sys_operations"
    value        = "FALSE"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "audit_trail"
    value        = "NONE"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "global_names"
    value        = "FALSE"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "remote_listener"
    value        = "10.0.159.100:1521"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "sec_max_failed_login_attempts"
    value        = "4"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "sec_protocol_error_further_action"
    value        = "(DROP,15)"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "sec_protocol_error_trace_action"
    value        = "NONE"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "sec_return_server_release_banner"
    value        = "TRUE"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "sql92_security"
    value        = "FALSE"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "_trace_files_public"
    value        = "TRUE"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "resource_limit"
    value        = "FALSE"
  }
}

data "aws_rds_engine_version" "oracle-ee" {
  engine = "oracle-ee"
  latest = true
}

resource "null_resource" "stop_rds" {
  depends_on = [
    aws_db_instance.oracle-ee
  ]
  triggers = {
    region     = var.region
    identifier = aws_db_instance.oracle-ee.identifier
  }
  provisioner "local-exec" {
    # interpreter = ["/bin/bash", "-c"]
    command = <<EOF
export AWS_REGION=${self.triggers.region}

while true; do
  status="$(aws rds describe-db-instances --db-instance-identifier ${self.triggers.identifier} --query DBInstances[0].DBInstanceStatus --output text)"
  if [ "$status" = "available" ]; then
    aws rds stop-db-instance --db-instance-identifier ${self.triggers.identifier}
    break
  else
    echo "Waiting for database: $rds to be available"
    sleep 60
  fi
done
while true; do
  status="$(aws rds describe-db-instances --db-instance-identifier ${self.triggers.identifier} --query DBInstances[0].DBInstanceStatus --output text)"
  if [ "$status" = "stopped" ]; then
    break
  else
    echo "Waiting for database: $rds to be stopped"
    sleep 60
  fi
done

echo "RDS instance stopped."
EOF
  }
}