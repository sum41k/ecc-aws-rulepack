aws = {
    "green": [
        "ecc-aws-200-rds_cluster_deletion_protection_enabled",
        "ecc-aws-201-rds_instance_deletion_protection_enabled",
        "ecc-aws-207-rds_aurora_logging_enabled",
        "ecc-aws-519-vpc_vpn_2_tunnels_up",
        "ecc-aws-587-elasticsearch_reserved_instance_payment_failed",
        "ecc-aws-588-elasticsearch_reserved_instance_payment_pending",
        "ecc-aws-589-elasticsearch_reserved_instance_recent_purchases",
        "ecc-aws-591-reserved_rds_instance_payment_failed",
        "ecc-aws-592-reserved_rds_instance_payment_pending",
        "ecc-aws-593-reserved_rds_instance_recent_purchases",
        "ecc-aws-594-underutilized_rds_instance_storage",
        "ecc-aws-614-idle_rds_instance"
    ],
    "red": [
        "ecc-aws-022-ebs_volumes_too_old_snapshots",
        "ecc-aws-128-expired_route53_domain_names",
        "ecc-aws-207-rds_aurora_logging_enabled",
        "ecc-aws-253-glue_data_catalog_encrypted_with_kms_customer_master_keys",
        "ecc-aws-344-route53_domain_expires_in_30_days",
        "ecc-aws-519-vpc_vpn_2_tunnels_up",
        "ecc-aws-547-rds_instance_generation",
        "ecc-aws-552-dynamodb_tables_unused",
        "ecc-aws-571-stopped_rds_instances_removed",
        "ecc-aws-587-elasticsearch_reserved_instance_payment_failed",
        "ecc-aws-588-elasticsearch_reserved_instance_payment_pending",
        "ecc-aws-589-elasticsearch_reserved_instance_recent_purchases",
        "ecc-aws-591-reserved_rds_instance_payment_failed",
        "ecc-aws-592-reserved_rds_instance_payment_pending",
        "ecc-aws-593-reserved_rds_instance_recent_purchases",
        "ecc-aws-594-underutilized_rds_instance_storage",
        "ecc-aws-614-idle_rds_instance"
    ],
    "parallel": [
        "glue"
    ]
}

