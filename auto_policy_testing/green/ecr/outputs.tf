output "ecr" {
  value = {
    ecr_repository = aws_ecr_repository.this.arn
  }
}
