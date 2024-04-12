output "security-group" {
  value = {
    security-group = {
      GroupId = aws_security_group.this.id,
      OwnerId = aws_security_group.this.owner_id
    }
    #     security-group                                                     = aws_security_group.this.id
    ecc-aws-064-default_security_group_every_vpc_restricts_all_traffic = aws_default_security_group.this.id
  }
}