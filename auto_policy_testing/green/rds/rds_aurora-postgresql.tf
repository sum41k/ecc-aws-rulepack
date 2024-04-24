resource "aws_rds_cluster" "aurora-postgresql" {
  cluster_identifier              = "${module.naming.resource_prefix.rds_cluster}-aurora-postgresql"
  engine                          = "aurora-postgresql"
  engine_version                  = data.aws_rds_engine_version.aurora-postgresql.version_actual
  master_username                 = "root"
  master_password                 = random_password.this.result
  apply_immediately               = true
  skip_final_snapshot             = true
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora-postgresql.id
  enabled_cloudwatch_logs_exports = ["postgresql"]
}

data "aws_rds_engine_version" "aurora-postgresql" {
  engine = "aurora-postgresql"
  latest = true
}

resource "aws_rds_cluster_parameter_group" "aurora-postgresql" {
  name   = "${module.naming.resource_prefix.rds_param_grp}-aurora-postgresql"
  family = data.aws_rds_engine_version.aurora-postgresql.parameter_group_family

  parameter {
    name  = "log_statement"
    value = "all"
  }

  parameter {
    name  = "log_min_duration_statement"
    value = "1"
  }

}

resource "aws_rds_cluster_instance" "aurora-postgresql" {
  identifier              = "${module.naming.resource_prefix.rds_instance}-aurora-postgresql"
  cluster_identifier      = aws_rds_cluster.aurora-postgresql.id
  engine                  = aws_rds_cluster.aurora-postgresql.engine
  engine_version          = aws_rds_cluster.aurora-postgresql.engine_version
  instance_class          = "db.t3.medium"
  apply_immediately       = true
  db_parameter_group_name = aws_db_parameter_group.aurora-postgresql.id
}

resource "aws_db_parameter_group" "aurora-postgresql" {
  name   = "${module.naming.resource_prefix.rds_param_grp}-aurora-postgresql"
  family = data.aws_rds_engine_version.aurora-postgresql.parameter_group_family

  # parameter {
  #   name  = "log_statement"
  #   value = "all"
  # }

  # parameter {
  #   name  = "log_min_duration_statement"
  #   value = "1"
  # }
}
