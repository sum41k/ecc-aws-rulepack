resource "aws_opensearch_domain" "this" {
  domain_name           = "domain-586-green"
  engine_version        = "OpenSearch_2.11"

  cluster_config {
    instance_type            = "t3.small.search"
    dedicated_master_enabled = false
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
    volume_type = "gp3"
    throughput  = 125
  }
}