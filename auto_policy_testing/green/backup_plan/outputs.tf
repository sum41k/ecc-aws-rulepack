output "backup_plan" {
  value = {
    backup-plan  = aws_backup_plan.this.id
    backup-vault = aws_backup_vault.this.arn
  }
}
