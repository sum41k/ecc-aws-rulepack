resource "aws_db_instance" "oracle-ee" {
  identifier                      = "${module.naming.resource_prefix.rds_instance}-oracle-ee"
  engine                          = "oracle-ee"
  instance_class                  = "db.t3.small"
  allocated_storage               = 10
  storage_type                    = "gp2"
  username                        = "root"
  password                        = random_password.this.result
  multi_az                        = false
  skip_final_snapshot             = true
  enabled_cloudwatch_logs_exports = ["alert", "audit", "listener", "trace"]
  parameter_group_name            = aws_db_parameter_group.oracle-ee.id
  delete_automated_backups        = true
}

resource "aws_db_parameter_group" "oracle-ee" {
  name   = "${module.naming.resource_prefix.rds_param_grp}-oracle-ee"
  family = data.aws_rds_engine_version.oracle-ee.parameter_group_family
  parameter {
    apply_method = "pending-reboot"
    name         = "audit_sys_operations"
    value        = "TRUE"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "audit_trail"
    value        = "XML"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "global_names"
    value        = "TRUE"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "remote_listener"
    value        = ""
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "sec_max_failed_login_attempts"
    value        = "2"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "sec_protocol_error_further_action"
    value        = "(DROP,3)"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "sec_protocol_error_trace_action"
    value        = "LOG"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "sec_return_server_release_banner"
    value        = "FALSE"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "sql92_security"
    value        = "TRUE"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "_trace_files_public"
    value        = "FALSE"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "resource_limit"
    value        = "TRUE"
  }
}

data "aws_rds_engine_version" "oracle-ee" {
  engine = "oracle-ee"
  latest = true
}