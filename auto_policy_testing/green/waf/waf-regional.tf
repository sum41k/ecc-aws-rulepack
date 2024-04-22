resource "aws_wafregional_ipset" "this" {
  name = module.naming.resource_prefix.waf_ip_set

  ip_set_descriptor {
    type  = "IPV4"
    value = "1.1.1.0/24"
  }
}

resource "aws_wafregional_rule" "this" {
  name        = module.naming.resource_prefix.waf_rule
  metric_name = "WafRuleMetricGreen"

  predicate {
    data_id = aws_wafregional_ipset.this.id
    negated = false
    type    = "IPMatch"
  }
  depends_on = [aws_wafregional_ipset.this]
}

resource "aws_wafregional_rule_group" "this" {
  name        = module.naming.resource_prefix.waf_group
  metric_name = "WafRuleGroupMetricGreen"

  activated_rule {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_wafregional_rule.this.id
  }
}

resource "aws_wafregional_web_acl" "this" {
  name        = "${module.naming.resource_prefix.waf_acl}-1"
  metric_name = "WebaclMetricGreen"

  default_action {
    type = "ALLOW"
  }

  rule {
    override_action {
      type = "NONE"
    }
    priority = 1
    rule_id  = aws_wafregional_rule_group.this.id
    type     = "GROUP"
  }

  depends_on = [
    aws_wafregional_ipset.this,
    aws_wafregional_rule_group.this,
  ]
}

resource "aws_wafregional_web_acl" "this2" {
  name        = "${module.naming.resource_prefix.waf_acl}-2"
  metric_name = "WebaclMetricGreen"

  default_action {
    type = "ALLOW"
  }

  rule {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_wafregional_rule.this.id
    type     = "REGULAR"
  }

  depends_on = [
    aws_wafregional_ipset.this,
    aws_wafregional_rule.this,
  ]
}
