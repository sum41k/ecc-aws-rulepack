output "dax" {
  value = {
    dax = aws_dax_cluster.this.arn
  }
}
