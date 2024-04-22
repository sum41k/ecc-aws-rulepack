resource "aws_backup_vault" "this" {
  name = module.naming.resource_prefix.backup_vault
}

resource "aws_backup_plan" "this" {
  name = module.naming.resource_prefix.backup_plan

  rule {
    rule_name         = module.naming.resource_prefix.backup_plan
    target_vault_name = aws_backup_vault.this.name
    schedule          = "cron(0 12 * * ? *)"

    lifecycle {
      cold_storage_after = 365
    }
  }
}