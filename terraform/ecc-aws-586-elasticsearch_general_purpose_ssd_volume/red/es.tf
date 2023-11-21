resource "aws_opensearch_domain" "this" {
  domain_name           = "domain-586-red"
  engine_version        = "OpenSearch_2.11"

  cluster_config {
    instance_type            = "t2.small.search"
    dedicated_master_enabled = false
  }
  
  ebs_options {
    ebs_enabled = true
    volume_size = 35
    volume_type = "io1"
    iops        = 1000
  }
}
