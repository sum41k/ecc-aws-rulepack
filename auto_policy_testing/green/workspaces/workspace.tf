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

  workspace_creation_properties {
    enable_maintenance_mode = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.workspaces-default-service-access,
    aws_iam_role_policy_attachment.workspaces-default-self-service-access
  ]
}

resource "aws_workspaces_workspace" "this" {
  directory_id = aws_workspaces_directory.this.id
  bundle_id    = data.aws_workspaces_bundle.this.id
  user_name    = "Administrator"

  root_volume_encryption_enabled = true
  user_volume_encryption_enabled = true
  volume_encryption_key          = data.terraform_remote_state.common.outputs.kms_key_arn

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


## Can not be created from encrypted Workspace
# data "external" "this" {
#   program = ["bash", "-c", "aws workspaces create-workspace-image --name autotest-green-image --description autotest-green-image --workspace-id ${aws_workspaces_workspace.this.id} | jq -r -c '{image_id: .ImageId }'"]

#   depends_on = [ aws_workspaces_workspace.this ]
# }

# resource "null_resource" "this" {
#   triggers = {
#    image_id = data.external.this.result["image_id"]
#   }

#   provisioner "local-exec" {
#     when    = destroy
#     command = "aws workspaces delete-workspace-image --image-id ${self.triggers.image_id}"
#   }

#   depends_on = [ aws_workspaces_workspace.this, data.external.this ]
# }