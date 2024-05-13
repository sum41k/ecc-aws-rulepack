output "workspaces" {
  value = {
    workspaces           = aws_workspaces_workspace.this.id,
    workspaces-directory = aws_workspaces_directory.this.id
  }
}