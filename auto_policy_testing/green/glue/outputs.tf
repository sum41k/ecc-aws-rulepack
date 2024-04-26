output "glue" {
  value = {
    glue-catalog                = aws_glue_data_catalog_encryption_settings.this.id
    glue-job                    = aws_glue_job.this.id
    glue-security-configuration = aws_glue_security_configuration.this.id
  }
}
