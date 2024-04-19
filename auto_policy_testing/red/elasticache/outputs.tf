output "elasticache" {
  value = {
    elasticache-group = aws_elasticache_replication_group.this.arn
  }
}