resource "aws_docdb_cluster" "docdb" {
  cluster_identifier              = "${module.naming.resource_prefix.rds_instance}-docdb"
  engine                          = "docdb"
  engine_version                  = data.aws_rds_engine_version.docdb.version_actual
  master_username                 = "root"
  master_password                 = random_password.this.result
  skip_final_snapshot             = true
  enabled_cloudwatch_logs_exports = ["audit"]
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.docdb.id
}

data "aws_rds_engine_version" "docdb" {
  engine = "docdb"
  latest = true
}

resource "aws_docdb_cluster_instance" "docdb" {
  identifier         = "${module.naming.resource_prefix.rds_instance}-docdb"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = "db.t3.medium"
}

resource "aws_docdb_cluster_parameter_group" "docdb" {
  name   = "${module.naming.resource_prefix.rds_param_grp}-docdb"
  family = data.aws_rds_engine_version.docdb.parameter_group_family
}