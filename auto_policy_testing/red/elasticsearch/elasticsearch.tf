resource "aws_elasticsearch_domain" "this" {
  provider              = aws.provider2
  domain_name           = module.naming.resource_prefix.elasticsearch
  elasticsearch_version = "7.4"

  cluster_config {
    instance_type = "m5.large.elasticsearch"
  }

  encrypt_at_rest {
    enabled = false
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 35
    volume_type = "io1"
    iops        = 1000
  }

  auto_tune_options {
    desired_state        = "DISABLED"
    rollback_on_disable  = "NO_ROLLBACK"
    
  }
}
