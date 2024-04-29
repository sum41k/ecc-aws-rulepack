output "rrset" {
  value = {
    rrset = [
      {
        "Name" : "${aws_route53_record.this1.name}."
        "Type" : aws_route53_record.this1.type
        "c7n:parent-id" : "/hostedzone/${aws_route53_record.this1.zone_id}"
      },
      {
        "Name" : "${aws_route53_record.this2.name}."
        "Type" : aws_route53_record.this2.type
        "c7n:parent-id" : "/hostedzone/${aws_route53_record.this2.zone_id}"
      },
      {
        "Name" : "${aws_route53_record.this3.name}."
        "Type" : aws_route53_record.this3.type
        "c7n:parent-id" : "/hostedzone/${aws_route53_record.this3.zone_id}"
      },
    ]
  }
}
