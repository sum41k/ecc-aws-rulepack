resource "aws_wafregional_web_acl" "this" {
  name        = module.naming.resource_prefix.waf_acl
  metric_name = "WebaclMetricRed"

  default_action {
    type = "ALLOW"
  }
}
