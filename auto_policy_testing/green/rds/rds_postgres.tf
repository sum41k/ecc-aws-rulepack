resource "aws_db_instance" "postgres" {
  identifier                      = "${module.naming.resource_prefix.rds_instance}-postgres"
  engine                          = "postgres"
  instance_class                  = "db.t3.micro"
  allocated_storage               = 10
  engine_version                  = "16.1"
  storage_type                    = "gp2"
  username                        = "root"
  password                        = random_password.this.result
  multi_az                        = false
  skip_final_snapshot             = true
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  parameter_group_name            = aws_db_parameter_group.postgres.id
  delete_automated_backups        = true
}

resource "aws_db_parameter_group" "postgres" {
  name   = "${module.naming.resource_prefix.rds_param_grp}-postgres"
  family = "postgres16"

  parameter {
    name  = "log_statement"
    value = "all"
  }
  parameter {
    name  = "log_min_duration_statement"
    value = "1"
  }
  parameter {
    name  = "log_rotation_age"
    value = "60"
  }
  parameter {
    name  = "log_rotation_size"
    value = "1000000"
  }
  parameter {
    name  = "debug_print_parse"
    value = "0"
  }
  parameter {
    name  = "debug_print_rewritten"
    value = "0"
  }
  parameter {
    name  = "debug_pretty_print"
    value = "1"
  }
  parameter {
    name  = "log_connections"
    value = "1"
  }
  parameter {
    name  = "log_disconnections"
    value = "1"
  }
  parameter {
    name  = "log_error_verbosity"
    value = "default"
  }
  parameter {
    name  = "log_hostname"
    value = "0"
  }
  parameter {
    name  = "log_destination"
    value = "csvlog"
  }
  parameter {
    name  = "log_checkpoints"
    value = "1"
  }
  parameter {
    name  = "log_lock_waits"
    value = "1"
  }
  parameter {
    name  = "log_duration"
    value = "1"
  }
  parameter {
    name  = "log_parser_stats"
    value = "0"
  }
  parameter {
    name  = "log_planner_stats"
    value = "0"
  }
  parameter {
    name  = "log_executor_stats"
    value = "0"
  }
  parameter {
    name  = "log_min_error_statement"
    value = "error"
  }

}
