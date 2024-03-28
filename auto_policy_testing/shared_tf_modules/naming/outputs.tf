output "resource_prefix" {
  value = {
    security_group = "${local.suffix}_${var.resource_type}_sg_${local.compliance_status}"
    vpc            = "${local.suffix}_${var.resource_type}_vpc_${local.compliance_status}"
    ecr_repository = "${local.suffix}_${var.resource_type}_ecr_repository_${local.compliance_status}"
    lambda_function = "${local.suffix}_${var.resource_type}_function_${local.compliance_status}"
    iam_role        = "${local.suffix}_${var.resource_type}_role_${local.compliance_status}"
    iam_policy      = "${local.suffix}_${var.resource_type}_iam_policy_${local.compliance_status}"
    ec2_instance    = "${local.suffix}_${var.resource_type}_ec2_instance_${local.compliance_status}"
  }
}

output "default_tags" {
  value = local.default_tags
}