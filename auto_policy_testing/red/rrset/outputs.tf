output "rrset" {
  value = {
    rrset = {
      "Name" : "${aws_route53_record.this.name}."
      "Type" : aws_route53_record.this.type
      "c7n:parent-id" : "/hostedzone/${aws_route53_record.this.zone_id}"
    }
  }
}
