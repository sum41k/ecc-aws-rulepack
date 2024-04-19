output "resource_prefix" {
  value = {
    elastic_beanstalk = "${local.suffix}-${var.resource_type}-elastic_beanstalk-${local.compliance_status}"
    elasticache    = "${local.suffix}-${var.resource_type}-elasticache-${local.compliance_status}"
    waf_acl            = "${local.suffix}-${var.resource_type}-waf_acl-${local.compliance_status}"
    waf_rule            = "${local.suffix}-${var.resource_type}-waf_rule-${local.compliance_status}"
    waf_group            = "${local.suffix}-${var.resource_type}-waf_grp-${local.compliance_status}"
    waf_ip_set      = "${local.suffix}-${var.resource_type}-ipset-${local.compliance_status}"
    dynamodb_table = "${local.suffix}-${var.resource_type}-table-${local.compliance_status}"
    backup_vault   = "${local.suffix}-${var.resource_type}-vault-${local.compliance_status}"
    backup_plan    = "${local.suffix}-${var.resource_type}-plan-${local.compliance_status}"
    app_flow       = "${local.suffix}-${var.resource_type}-appflow-${local.compliance_status}"
    cfn            = "${local.suffix}-${var.resource_type}-cfn-${local.compliance_status}"
    sns            = "${local.suffix}_${var.resource_type}_sns_${local.compliance_status}"
    kms_key        = "${local.suffix}_${var.resource_type}_key_${local.compliance_status}"
    ami            = "${local.suffix}_${var.resource_type}_ami_${local.compliance_status}"
    ebs_volume     = "${local.suffix}_${var.resource_type}_volume_${local.compliance_status}"
    ebs_snapshot   = "${local.suffix}_${var.resource_type}_snap_${local.compliance_status}"
    security_group = "${local.suffix}_${var.resource_type}_sg_${local.compliance_status}"
    vpc            = "${local.suffix}_${var.resource_type}_vpc_${local.compliance_status}"
    ecr_repository = "${local.suffix}_${var.resource_type}_repo_${local.compliance_status}"
    lambda_function = "${local.suffix}_${var.resource_type}_fun_${local.compliance_status}"
    iam_role        = "${local.suffix}_${var.resource_type}_role_${local.compliance_status}"
    iam_policy      = "${local.suffix}_${var.resource_type}_policy_${local.compliance_status}"
    ec2_instance    = "${local.suffix}_${var.resource_type}_instance_${local.compliance_status}"
    apigwv2_stage   = "${local.suffix}_${var.resource_type}_apigwv2_stage_${local.compliance_status}"
    apigwv2         = "${local.suffix}_${var.resource_type}_apigwv2_${local.compliance_status}"
    cw_log_group    = "${local.suffix}_${var.resource_type}_lg_${local.compliance_status}"
    s3_bucket       = "${local.suffix}-${var.resource_type}-bucket-${local.compliance_status}"
    vpn_gtw         = "${local.suffix}-${var.resource_type}-vpn_gtw-${local.compliance_status}"
    
  }
}

output "default_tags" {
  value = local.default_tags
}