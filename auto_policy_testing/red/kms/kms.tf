resource "aws_kms_key" "this1" {
  provider                = aws.provider2
  description             = "Key to encrypt and decrypt secret parameters"
  key_usage               = "ENCRYPT_DECRYPT"
  policy                  = data.aws_iam_policy_document.this.json
  deletion_window_in_days = 7
  is_enabled              = false
  enable_key_rotation     = false
}

resource "aws_kms_alias" "this1" {
  name          = "alias/${module.naming.resource_prefix.kms_key}-1"
  target_key_id = aws_kms_key.this1.key_id
}

resource "aws_kms_key" "this2" {
  description             = "Key to encrypt and decrypt secret parameters"
  key_usage               = "ENCRYPT_DECRYPT"
  policy                  = data.aws_iam_policy_document.this.json
  deletion_window_in_days = 7
  is_enabled              = false
  enable_key_rotation     = false
}

resource "aws_kms_alias" "this2" {
  name          = "alias/${module.naming.resource_prefix.kms_key}-2"
  target_key_id = aws_kms_key.this2.key_id
}

resource "null_resource" "delete_kms_key" {
  depends_on = [aws_kms_key.this2]

  provisioner "local-exec" {
    command = "aws kms schedule-key-deletion --key-id ${aws_kms_key.this2.key_id} --pending-window-in-days 7"
  }
}

resource "aws_kms_key" "this3" {
  description             = "Key to encrypt and decrypt secret parameters"
  key_usage               = "ENCRYPT_DECRYPT"
  policy                  = data.aws_iam_policy_document.this.json
  deletion_window_in_days = 7
  is_enabled              = true
  enable_key_rotation     = false
}

resource "aws_kms_alias" "this3" {
  name          = "alias/${module.naming.resource_prefix.kms_key}-3"
  target_key_id = aws_kms_key.this3.key_id
}