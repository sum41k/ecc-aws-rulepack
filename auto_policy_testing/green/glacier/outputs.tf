output "glacier" {
  value = {
    glacier =  aws_glacier_vault.this.arn
  }
}
