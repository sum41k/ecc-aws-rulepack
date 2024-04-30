output "kms" {
  value = {
    kms-key = aws_kms_key.this.id
  }
}
