resource "aws_glue_data_catalog_encryption_settings" "this" {
  data_catalog_encryption_settings {
    encryption_at_rest {
      catalog_encryption_mode = "SSE-KMS"
      sse_aws_kms_key_id      = data.terraform_remote_state.common.outputs.kms_key_arn
    }

    connection_password_encryption {
      return_connection_password_encrypted = true
      aws_kms_key_id                       = data.terraform_remote_state.common.outputs.kms_key_arn
    }
  }
}

