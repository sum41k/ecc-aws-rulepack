resource "aws_backup_vault" "this" {
  name        = module.naming.resource_prefix.backup_vault
  kms_key_arn = data.terraform_remote_state.common.outputs.kms_key_arn
}

resource "aws_backup_plan" "this" {
  name = module.naming.resource_prefix.backup_plan

  rule {
    rule_name         = module.naming.resource_prefix.backup_plan
    target_vault_name = aws_backup_vault.this.name
    schedule          = "cron(0 12 * * ? *)"

    lifecycle {
      cold_storage_after = 90
      delete_after       = 180
    }
  }
}