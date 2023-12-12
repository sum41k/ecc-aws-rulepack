resource "aws_opensearch_domain" "this" {
  domain_name    = "domain-566-green"
  engine_version = "OpenSearch_2.11"

  cluster_config {
    instance_type = "c6g.large.search"
  }
  
  auto_tune_options {
    desired_state        = "ENABLED"
    rollback_on_disable  = "NO_ROLLBACK"
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }
}
