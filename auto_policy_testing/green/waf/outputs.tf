output "waf" {
  value = {
    waf = [
      aws_wafregional_web_acl.this.id, 
      aws_wafregional_web_acl.this2.id
    ]
  }
}