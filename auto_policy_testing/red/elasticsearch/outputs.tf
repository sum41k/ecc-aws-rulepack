output "elasticsearch" {
  value = {
    elasticsearch = aws_elasticsearch_domain.this.arn
  }
}