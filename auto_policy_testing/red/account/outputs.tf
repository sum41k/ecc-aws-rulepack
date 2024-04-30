output "account" {
  value = {
    account = data.aws_caller_identity.this.account_id
  }
}
