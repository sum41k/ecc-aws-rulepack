resource "aws_wafregional_web_acl" "this" {
  name        = "914_webacl_red"
  metric_name = "914WebaclMetricRed"

  default_action {
    type = "ALLOW"
  }
}