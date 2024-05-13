########################
###   WARNING !!!    ###
# This is a very expensive resource. Each WorkSpace will cost $7.25/month + $0.17/hour.

data "aws_workspaces_bundle" "this" {
  owner = "Amazon"
  name  = "Value with Amazon Linux 2"
}

resource "random_password" "this" {
  length           = 12
  special          = true
  numeric          = true
  override_special = "!#$%*()-_=+[]{}:?"
}

resource "aws_directory_service_directory" "this" {
  name     = "${module.naming.resource_prefix.directory}.com"
  password = random_password.this.result
  size     = "Small"

  vpc_settings {
    vpc_id     = data.terraform_remote_state.common.outputs.vpc_id
    subnet_ids = [data.terraform_remote_state.common.outputs.vpc_subnet_1_id, data.terraform_remote_state.common.outputs.vpc_subnet_3_id]
  }
}

resource "aws_workspaces_directory" "this" {
  directory_id = aws_directory_service_directory.this.id
  subnet_ids   = [data.terraform_remote_state.common.outputs.vpc_subnet_1_id, data.terraform_remote_state.common.outputs.vpc_subnet_3_id]

  workspace_access_properties {
    device_type_web = "ALLOW"
  }
  workspace_creation_properties {
    enable_maintenance_mode = false
  }

  depends_on = [
    aws_iam_role_policy_attachment.workspaces-default-service-access,
    aws_iam_role_policy_attachment.workspaces-default-self-service-access
  ]
}

data "aws_kms_key" "workspaces" {
  key_id = "alias/aws/workspaces"
}

resource "aws_workspaces_workspace" "this" {
  directory_id = aws_workspaces_directory.this.id
  bundle_id    = data.aws_workspaces_bundle.this.id
  user_name    = "Administrator"

  root_volume_encryption_enabled = false
  user_volume_encryption_enabled = true
  volume_encryption_key          = data.aws_kms_key.workspaces.arn

  workspace_properties {
    compute_type_name                         = "VALUE"
    user_volume_size_gib                      = 10
    root_volume_size_gib                      = 80
    running_mode                              = "AUTO_STOP"
    running_mode_auto_stop_timeout_in_minutes = 60
  }

  depends_on = [
    aws_iam_role_policy_attachment.workspaces-default-service-access,
    aws_workspaces_directory.this
  ]
}