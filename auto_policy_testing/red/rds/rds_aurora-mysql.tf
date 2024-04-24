resource "aws_rds_cluster" "aurora-mysql" {
  provider                        = aws.provider2
  cluster_identifier              = "${module.naming.resource_prefix.rds_cluster}-aurora-mysql"
  engine                          = "aurora-mysql"
  engine_version                  = data.aws_rds_engine_version.aurora-mysql.version_actual
  master_username                 = "admin"
  master_password                 = random_password.this.result
  apply_immediately               = true
  storage_encrypted               = false
  skip_final_snapshot             = true
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora-mysql.id
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
}

data "aws_rds_engine_version" "aurora-mysql" {
  engine = "aurora-mysql"
  latest = true
}

resource "aws_rds_cluster_parameter_group" "aurora-mysql" {
  name   = "${module.naming.resource_prefix.rds_param_grp}-aurora-mysql"
  family = data.aws_rds_engine_version.aurora-mysql.parameter_group_family

  parameter {
    name  = "general_log"
    value = "1"
  }

  parameter {
    name  = "log_output"
    value = "FILE"
  }

}

resource "aws_rds_cluster_instance" "aurora-mysql" {
  identifier              = "${module.naming.resource_prefix.rds_instance}-aurora-mysql"
  cluster_identifier      = aws_rds_cluster.aurora-mysql.id
  engine                  = aws_rds_cluster.aurora-mysql.engine
  engine_version          = aws_rds_cluster.aurora-mysql.engine_version
  instance_class          = "db.t3.medium"
  apply_immediately       = true
  db_parameter_group_name = aws_db_parameter_group.aurora-mysql.id
}

resource "aws_db_parameter_group" "aurora-mysql" {
  name   = "${module.naming.resource_prefix.rds_param_grp}-aurora-mysql"
  family = data.aws_rds_engine_version.aurora-mysql.parameter_group_family

  parameter {
    name  = "general_log"
    value = "1"
  }
}
