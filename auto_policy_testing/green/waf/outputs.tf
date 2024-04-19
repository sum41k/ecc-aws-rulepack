output "waf" {
  value = {
    ecc-aws-524-waf_regional_webacl_not_empty = [aws_wafregional_web_acl.this.id, aws_wafregional_web_acl.this2.id]
    ecc-aws-527-waf_global_webacl_not_empty   = [aws_waf_web_acl.this.id, aws_waf_web_acl.this2.id]
  }
}