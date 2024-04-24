output "efs" {
  value = {
    efs = aws_efs_file_system.this.arn 
  }
}
