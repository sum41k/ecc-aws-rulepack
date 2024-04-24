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
  enabled_cloudwatch_logs_exports = ["postgresql"]
  parameter_group_name            = aws_db_parameter_group.postgres.id
  delete_automated_backups        = true
}

resource "aws_db_parameter_group" "postgres" {
  name   = "${module.naming.resource_prefix.rds_param_grp}-postgres"
  family = "postgres16"

  parameter {
    name  = "log_rotation_age"
    value = "120"
  }
  parameter {
    name  = "debug_print_parse"
    value = "1"
  }
  parameter {
    name  = "debug_print_rewritten"
    value = "1"
  }
  parameter {
    name  = "debug_print_plan"
    value = "1"
  }
  parameter {
    name  = "log_error_verbosity"
    value = "terse"
  }
  parameter {
    name  = "log_hostname"
    value = "1"
  }
  parameter {
    name  = "log_statement"
    value = "none"
  }
  parameter {
    name  = "log_checkpoints"
    value = "0"
  }
  parameter {
    name  = "log_parser_stats"
    value = "1"
  }
  parameter {
    name  = "log_planner_stats"
    value = "1"
  }
  parameter {
    name  = "log_executor_stats"
    value = "1"
  }
  parameter {
    name  = "log_min_error_statement"
    value = "info"
  }
}
