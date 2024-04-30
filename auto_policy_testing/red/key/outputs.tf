output "key" {
  value = {
    key-pair = aws_key_pair.this.key_pair_id
  }
}
