output "glue-catalog" {
  value = {
    glue-catalog = aws_glue_data_catalog_encryption_settings.this.id
    # ecc-aws-253-glue_data_catalog_encrypted_with_kms_customer_master_keys = aws_glue_data_catalog_encryption_settings.this2.id
  }
}
