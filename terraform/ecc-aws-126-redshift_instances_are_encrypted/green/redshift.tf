resource "aws_redshift_cluster" "this" {
  cluster_identifier  = "redshift-126-green"
  database_name       = "redshiftgreen"
  master_username     = "root"
  master_password     = random_password.this.result
  node_type           = "dc2.large"
  skip_final_snapshot = true
  
  encrypted           = true
}

resource "random_password" "this" {
  length           = 12
  special          = true
  numeric          = true
  min_numeric      = 1
  override_special = "!#$%*()-_=+[]{}:?"
}