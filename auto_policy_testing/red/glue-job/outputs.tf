output "glue-catalog" {
  value = {
    glue-job = aws_glue_job.this.id
  }
}
