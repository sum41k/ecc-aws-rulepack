resource "aws_wafregional_ipset" "this" {
  name = "524_ipset_green"

  ip_set_descriptor {
    type  = "IPV4"
    value = "1.1.1.0/24"
  }
}

resource "aws_wafregional_rule" "this" {
  name        = "524_waf_rule_green"
  metric_name = "524WafRuleMetricGreen"

  predicate {
    data_id = aws_wafregional_ipset.this.id
    negated = false
    type    = "IPMatch"
  }
  depends_on = [aws_wafregional_ipset.this]
}

resource "aws_wafregional_rule_group" "this" {
  name        = "524_waf_rule_group_green"
  metric_name = "524WafRuleGroupMetricGreen"

  activated_rule {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_wafregional_rule.this.id
  }
}

resource "aws_wafregional_web_acl" "this" {
  name        = "524_webacl_green"
  metric_name = "524WebaclMetricGreen"

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
  name        = "524_webacl_green2"
  metric_name = "524WebaclMetricGreen2"

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

resource "aws_waf_ipset" "this" {
  name = "527_ipset_green"

  ip_set_descriptors {
    type  = "IPV4"
    value = "1.1.1.0/24"
  }
}

resource "aws_waf_rule" "this" {
  name        = "527_waf_rule_green"
  metric_name = "527WafRuleMetricGreen"

   predicates {
    data_id = aws_waf_ipset.this.id
    negated = false
    type    = "IPMatch"
  }
  depends_on  = [aws_waf_ipset.this]
}

resource "aws_waf_rule_group" "this" {
  name        = "527_waf_rule_group_green"
  metric_name = "527WafRuleGroupMetricGreen"

  activated_rule {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = aws_waf_rule.this.id
  }
}

resource "aws_waf_web_acl" "this" {
  name        = "527_webacl_green"
  metric_name = "527WebaclMetricGreen"

  default_action {
    type = "ALLOW"
  }

  rules {
    override_action{
      type = "NONE"
    }
    priority = 1
    rule_id  = aws_waf_rule_group.this.id
    type = "GROUP"
  }
  
  depends_on = [
    aws_waf_ipset.this,
    aws_waf_rule.this,
  ]
}

resource "aws_waf_web_acl" "this2" {
  name        = "527_webacl_green2"
  metric_name = "527WebaclMetricGreen2"

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
    aws_waf_rule.this,
  ]
}