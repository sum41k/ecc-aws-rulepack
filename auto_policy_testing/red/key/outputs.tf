output "key" {
  value = {
    key-pair = aws_kms_key.this.id 
  }
}
