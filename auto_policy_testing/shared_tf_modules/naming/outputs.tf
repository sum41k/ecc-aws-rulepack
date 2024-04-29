output "resource_prefix" {
  value = {
    elasticsearch     = "${local.suffix}-elasticsearch-${local.compliance_status}"
    glue_security_configuration = "${local.suffix}_${var.resource_type}_glue_security_configuration_${local.compliance_status}"
    glue_job          = "${local.suffix}_${var.resource_type}_glue_job_${local.compliance_status}"
    hostedzone        = "${local.suffix}_${var.resource_type}_hostedzone_${local.compliance_status}"
    r53record         = "${local.suffix}_${var.resource_type}_record_${local.compliance_status}"
    graphql_api       = "${local.suffix}_${var.resource_type}_graphql_api_${local.compliance_status}"
    glacier           = "${local.suffix}_${var.resource_type}_glacier_${local.compliance_status}"
    event_bus         = "${local.suffix}_${var.resource_type}_event_bus_${local.compliance_status}"
    firehose          = "${local.suffix}_${var.resource_type}_firehose_${local.compliance_status}" 
    efs               = "${local.suffix}_${var.resource_type}_efs_${local.compliance_status}"
    dlm_policy        = "${local.suffix}_${var.resource_type}_dlm_policy_${local.compliance_status}"
    beanstalk         = "${local.suffix}_${var.resource_type}_beanstalk_${local.compliance_status}"
    beanstalk_env     = "${local.suffix}-beanstalk-env-${local.compliance_status}"
    elasticache       = "${local.suffix}-${var.resource_type}-elasticache-${local.compliance_status}"
    waf_acl           = "${local.suffix}_${var.resource_type}_waf_acl_${local.compliance_status}"
    waf_rule          = "${local.suffix}_${var.resource_type}_waf_rule_${local.compliance_status}"
    waf_group         = "${local.suffix}_${var.resource_type}_waf_grp_${local.compliance_status}"
    waf_ip_set        = "${local.suffix}_${var.resource_type}_ipset_${local.compliance_status}"
    dynamodb_table    = "${local.suffix}_${var.resource_type}_table_${local.compliance_status}"
    backup_vault      = "${local.suffix}_${var.resource_type}_vault_${local.compliance_status}"
    backup_plan       = "${local.suffix}_${var.resource_type}_plan_${local.compliance_status}"
    app_flow          = "${local.suffix}-${var.resource_type}-appflow-${local.compliance_status}"
    cfn               = "${local.suffix}-${var.resource_type}-cfn-${local.compliance_status}"
    sns               = "${local.suffix}_${var.resource_type}_sns_${local.compliance_status}"
    kms_key           = "${local.suffix}_${var.resource_type}_key_${local.compliance_status}"
    ami               = "${local.suffix}_${var.resource_type}_ami_${local.compliance_status}"
    ebs_volume        = "${local.suffix}_${var.resource_type}_volume_${local.compliance_status}"
    ebs_snapshot      = "${local.suffix}_${var.resource_type}_snap_${local.compliance_status}"
    security_group    = "${local.suffix}_${var.resource_type}_sg_${local.compliance_status}"
    vpc               = "${local.suffix}_${var.resource_type}_vpc_${local.compliance_status}"
    ecr_repository    = "${local.suffix}_${var.resource_type}_repo_${local.compliance_status}"
    lambda_function   = "${local.suffix}_${var.resource_type}_fun_${local.compliance_status}"
    iam_role          = "${local.suffix}_${var.resource_type}_role_${local.compliance_status}"
    iam_policy        = "${local.suffix}_${var.resource_type}_policy_${local.compliance_status}"
    ec2_instance      = "${local.suffix}_${var.resource_type}_instance_${local.compliance_status}"
    apigwv2_stage     = "${local.suffix}_${var.resource_type}_apigwv2_stage_${local.compliance_status}"
    apigwv2           = "${local.suffix}_${var.resource_type}_apigwv2_${local.compliance_status}"
    cw_log_group      = "${local.suffix}_${var.resource_type}_lg_${local.compliance_status}"
    s3_bucket         = "${local.suffix}-${var.resource_type}-bucket-${local.compliance_status}"
    vpn_gtw           = "${local.suffix}-${var.resource_type}-vpn_gtw-${local.compliance_status}"
    rds_instance      = "${local.suffix}-${var.resource_type}-instance-${local.compliance_status}"
    rds_cluster      = "${local.suffix}-${var.resource_type}-cluster-${local.compliance_status}"
    rds_param_grp     = "${local.suffix}-${var.resource_type}-paramgroup-${local.compliance_status}"
    rds_option_grp     = "${local.suffix}-${var.resource_type}-optgroup-${local.compliance_status}"
    dax               = "${local.suffix}-${var.resource_type}-${local.compliance_status}"
  }
}

output "default_tags" {
  value = local.default_tags
}