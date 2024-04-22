resource "aws_waf_ipset" "this" {
  name = module.naming.resource_prefix.waf_ip_set

  ip_set_descriptors {
    type  = "IPV4"
    value = "1.1.1.0/24"
  }
}

resource "aws_waf_rule" "this" {
  name        = module.naming.resource_prefix.waf_rule
  metric_name = "WafRuleMetricGreen"

  predicates {
    data_id = aws_waf_ipset.this.id
    negated = false
    type    = "IPMatch"
  }
  depends_on = [aws_waf_ipset.this]
}

resource "aws_waf_rule_group" "this" {
  name        = module.naming.resource_prefix.waf_group
  metric_name = "WafRuleGroupMetricGreen"

  activated_rule {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.this.id
  }
}

resource "aws_waf_web_acl" "this" {
  name        = "${module.naming.resource_prefix.waf_acl}-1"
  metric_name = "WebaclMetricGreen"

  default_action {
    type = "ALLOW"
  }

  rules {
    override_action {
      type = "NONE"
    }
    priority = 1
    rule_id  = aws_waf_rule_group.this.id
    type     = "GROUP"
  }

  depends_on = [
    aws_waf_ipset.this,
    aws_waf_rule.this,
  ]
}

resource "aws_waf_web_acl" "this2" {
  name        = "${module.naming.resource_prefix.waf_acl}-2"
  metric_name = "WebaclMetricGreen"

  default_action {
    type = "ALLOW"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.this.id
  }

  depends_on = [
    aws_waf_ipset.this,
    aws_waf_rule.this
  ]
}