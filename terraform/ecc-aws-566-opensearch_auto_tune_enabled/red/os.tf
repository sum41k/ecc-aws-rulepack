resource "aws_opensearch_domain" "this" {
  domain_name    = "domain-566-red"
  engine_version = "OpenSearch_2.11"

  cluster_config {
    instance_type = "t3.small.search"
  }
  
  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }
}
