# Changelog

## [v5.0] - 2024-04-17
### :sparkles: New Policies
- [`1f3b9fc`](https://github.com/epam/ecc-aws-rulepack/commit/1f3b9fcac5a3136ecd420164580e4eb83dd3f633) - added policy ecc-aws-218-secrets_manager_rotation_enabled
- [`7428c6c`](https://github.com/epam/ecc-aws-rulepack/commit/7428c6c1232421ca86e3b8ad92e194878bb10713) - added policy ecc-aws-219-secrets_manager_successful_rotation_check
- [`efd83c8`](https://github.com/epam/ecc-aws-rulepack/commit/efd83c8b23da994c29f3bc354ce4e6ea7d6781fc) - added policy ecc-aws-220-secrets_manager_unused_secret

### :wrench: Updates
- [`da86c3c`](https://github.com/epam/ecc-aws-rulepack/commit/da86c3cf3f6ebbd91e1f6f4a161125cc19cf0b29) - update iam/All-permission_*.json files
- [`6f9805f`](https://github.com/epam/ecc-aws-rulepack/commit/6f9805f0a2b610248e1b2655aa6365d17785082d) - update terraforms 001-288 to provider version 5
- [`0bba04a`](https://github.com/epam/ecc-aws-rulepack/commit/0bba04ad5032b1923bd9da789ff135072b22f346) - update terraforms 289-347 to provider version 5
- [`169df56`](https://github.com/epam/ecc-aws-rulepack/commit/169df56a7702a72e42516bdcd97c0c5bc596724d) - update terraform to provider version 5 for policies 348, 349, 366, 377, 378, 379, 458, 462, 469, 471, 472, 489, 490, 517, 531
- [`5575d28`](https://github.com/epam/ecc-aws-rulepack/commit/5575d280c07ad06a0a82a8bdc132aa59da50342f) - update terraform to provider version 5 for policies 386, 387, 388, 374, 491, 492, 493, 494, 520, 521, 365, 510, 506, 505, 534
- [`4d0821b`](https://github.com/epam/ecc-aws-rulepack/commit/4d0821b36b26794826e3d5de917a579f2d1124eb) - update terraforms to provider version 5 for a number of policies (see the list in the commit message)
- [`750679f`](https://github.com/epam/ecc-aws-rulepack/commit/750679fed1f0d0b1fd216b931765f387ffd0e8ce) - update terraforms to provider version 5 for a number of policies (see the list in the commit message)
- [`989598f`](https://github.com/epam/ecc-aws-rulepack/commit/989598fbc73846e7958b9e2ab6efb02ab33450e7) - update iam permissions for policies 396 and 476
- [`f333850`](https://github.com/epam/ecc-aws-rulepack/commit/f333850f63cf26a1cec86a65bd9ee7a01109bfce) - fix terraform for policies 383, 384, 385, 474, 475, 476, 479, 488, 513, 514, 529, 552, 503, 504, 461

### :adhesive_bandage: Terraform Fixes
- [`3608353`](https://github.com/epam/ecc-aws-rulepack/commit/3608353c760e2e8d6ef0c5846f0e569f24cf62c7) - fixed terraform for policy 186


### :heavy_minus_sign: Deletions
- [`205475a`](https://github.com/epam/ecc-aws-rulepack/commit/205475a7139390a0e77805a21b5ae0497497f924) - delete terraform for policy 016


## [v4.0] - 2024-01-25
### :sparkles: New Policies
- [`5254033`](https://github.com/epam/ecc-aws-rulepack/commit/52540332468f03dfcc1a2b931e09181152b324f1) - added policy ecc-aws-571-stopped_rds_instances_removed
- [`738f42b`](https://github.com/epam/ecc-aws-rulepack/commit/738f42bd048e3df080ca7ccce90a9da1c203ced6) - added policy ecc-aws-572-disabled_kms_keys_removed
- [`beb24ca`](https://github.com/epam/ecc-aws-rulepack/commit/beb24ca82185db48cc9870dd90aa1cc97da121e5) - added policy ecc-aws-573-unused_nat_gateway
- [`cd5cc3f`](https://github.com/epam/ecc-aws-rulepack/commit/cd5cc3feab1c1510e760636ee00d6199a51557d6) - added policy ecc-aws-575-ebs_volumes_attached_to_stopped_ec2_instances
- [`bb3e948`](https://github.com/epam/ecc-aws-rulepack/commit/bb3e948f5701fb93fb4d9fafef9fb37bcd29e672) - added policy ecc-aws-576-ec2_instance_dedicated_tenancy
- [`0a9ea6d`](https://github.com/epam/ecc-aws-rulepack/commit/0a9ea6d9073b6326ddaaafe28da7aed523da1be5) - added policy ecc-aws-577-reserved_ec2_instance_payment_failed
- [`2115d78`](https://github.com/epam/ecc-aws-rulepack/commit/2115d787c735ac55aa0d3cbbc08132231823788c) - added policy ecc-aws-578-reserved_ec2_instance_payment_pending
- [`6a6db51`](https://github.com/epam/ecc-aws-rulepack/commit/6a6db51a9ad8b18372bc534f980b706f3d6c6272) - added policy ecc-aws-579-reserved_ec2_instance_recent_purchases
- [`deffe48`](https://github.com/epam/ecc-aws-rulepack/commit/deffe48d5b1a70252fdf420a911ac7f051d4c67f) - added policy ecc-aws-580-reserved_instance_lease_expiration_in_30_days
- [`6edbb11`](https://github.com/epam/ecc-aws-rulepack/commit/6edbb11167e5947d5535985be49dea420c7cf795) - added policy ecc-aws-581-reserved_instance_lease_expiration_in_7_days
- [`f7c3aa5`](https://github.com/epam/ecc-aws-rulepack/commit/f7c3aa5933509352ebd80567572d39506d832f6b) - added policy ecc-aws-582-ecs_service_placement_strategy
- [`26ebbec`](https://github.com/epam/ecc-aws-rulepack/commit/26ebbecf184a7dc430d935fb6028fae5eb73f72f) - added policy ecc-aws-610-idle_ec2_instance
- [`27c142e`](https://github.com/epam/ecc-aws-rulepack/commit/27c142ec6ca56c975611f5e56d318c9faf9bd72a) - added policy ecc-aws-594-underutilized_rds_instance_storage
- [`3f062a3`](https://github.com/epam/ecc-aws-rulepack/commit/3f062a3df91860b457d0747031f0ad759f803fdb) - added policy  ecc-aws-614-idle_rds_instance
- [`9dabefa`](https://github.com/epam/ecc-aws-rulepack/commit/9dabefa6043e3b4185c8513b022f6c5b873870c8) - added policy ecc-aws-604-efs_without_lifecycle_management
- [`537e1fe`](https://github.com/epam/ecc-aws-rulepack/commit/537e1fe7603fb1c24492c85fa7ef3c3de3878041) - added policy ecc-aws-601-auto_scaling_group_statically_configured
- [`96f4899`](https://github.com/epam/ecc-aws-rulepack/commit/96f4899c5ec702935ba424fb5872dcf0191d2a10) - added policy ecc-aws-067-unauthorized_api_calls_alarm_exists
- [`e0902d1`](https://github.com/epam/ecc-aws-rulepack/commit/e0902d1b6c8fd02b74313924fa539e4ce29fd701) - added policy ecc-aws-493-ecs_container_insights_enabled
- [`1e356f7`](https://github.com/epam/ecc-aws-rulepack/commit/1e356f7ddbe1b5052023392dbfd10d92e57c2666) - added policy ecc-aws-376-api_gateway_http_api_and_websocket_api_logs_not_enabled
- [`a68480d`](https://github.com/epam/ecc-aws-rulepack/commit/a68480dbb280f24dabf73df19a2dfb73ae1e59cd) - added policy ecc-aws-872-access_to_cloudshell_restricted
- [`f96d13e`](https://github.com/epam/ecc-aws-rulepack/commit/f96d13e8320c0713a34861b9dd6a27a7fb726a0f) - added policy ecc-aws-549-ec2_instance_previous_generation
- [`6d7b1f0`](https://github.com/epam/ecc-aws-rulepack/commit/6d7b1f0c3be15454601ff1752be3ef40d4eaab07) - added policy ecc-aws-583-elb_classic_metadata
- [`cff94e1`](https://github.com/epam/ecc-aws-rulepack/commit/cff94e1f7b5584044a5269b196eb27d865a05371) - added policy ecc-aws-570-ebs_volumes_are_of_type_gp3_instead_of_io1
- [`5c119e8`](https://github.com/epam/ecc-aws-rulepack/commit/5c119e8a7f3a539884c1dc78fc003cb772f53e5e) - added policy ecc-aws-590-rds_general_purpose_ssd_storage_type
- [`ee0c927`](https://github.com/epam/ecc-aws-rulepack/commit/ee0c927d291803ebe93d85f8d44cb70fd9fb242f) - added policy ecc-aws-598-redshift_instance_generation
- [`113c7d8`](https://github.com/epam/ecc-aws-rulepack/commit/113c7d80b2753114315ee4c84306b100dc2a74dc) - added policy ecc-aws-566-opensearch_auto_tune_enabled
- [`4471865`](https://github.com/epam/ecc-aws-rulepack/commit/44718653034439748bb490bd36e99e81f8113bc1) - added policy ecc-aws-602-cloudwatch_logs_with_no_log_retention_period
- [`203dd37`](https://github.com/epam/ecc-aws-rulepack/commit/203dd37badfde1afbc98be94ce5113bbc76f4fcd) - added policy ecc-aws-586-elasticsearch_general_purpose_ssd_volume
- [`6ec8467`](https://github.com/epam/ecc-aws-rulepack/commit/6ec8467035a418bc05c53a67d633a0606199968d) - added policy ecc-aws-630-ec2_ami_not_in_use
- [`22888bc`](https://github.com/epam/ecc-aws-rulepack/commit/22888bcf5bc537fa5c8ad67a9cde06d9846c44d8) - added policy ecc-aws-591-reserved_rds_instance_payment_failed
- [`4267de2`](https://github.com/epam/ecc-aws-rulepack/commit/4267de28ebbf2faba3894eb0ac9dfcfc75db3807) - added policy ecc-aws-569-asg_propagate_tags_to_ec2_instances
- [`3477e96`](https://github.com/epam/ecc-aws-rulepack/commit/3477e96c195c757b7920531db44111a86a65bde4) - added policy ecc-aws-077-sign_in_without_mfa_alarm_exist
- [`4c9c06e`](https://github.com/epam/ecc-aws-rulepack/commit/4c9c06e331518921f02cafb1c9b91d497da407a7) - added policy ecc-aws-080-cloudtrail_configuration_changes_alarm_exists
- [`e49896e`](https://github.com/epam/ecc-aws-rulepack/commit/e49896e18529e320a5da7aece48b8a72103fd3d0) - added policy ecc-aws-079-iam_policy_changes_alarm_exist
- [`4c25919`](https://github.com/epam/ecc-aws-rulepack/commit/4c2591925f3b00b83c875e4c66760122b748553c) - added policy ecc-aws-145-organizations_changes_alarm_exists
- [`3658a3b`](https://github.com/epam/ecc-aws-rulepack/commit/3658a3b66599118c50390ef7c94bb37ca42c9047) - added policy ecc-aws-094-s3_bucket_policy_changes_alarm_exists
- [`743ef15`](https://github.com/epam/ecc-aws-rulepack/commit/743ef1572b8a955e12ce1601b6aba83d8c10d194) - added policy ecc-aws-082-cmk_key_disabling_or_deletion_alarm_exists
- [`710bdbb`](https://github.com/epam/ecc-aws-rulepack/commit/710bdbb3948b3f938a470bf4e88650d53c5b8f65) - added policy ecc-aws-095-aws_config_configuration_changes_alarm_exists
- [`1b7779f`](https://github.com/epam/ecc-aws-rulepack/commit/1b7779fa64d748c1ac638fbcb92b427194116ba4) - added policy ecc-aws-081-console_auth_failure_alarm_exists
- [`0d01684`](https://github.com/epam/ecc-aws-rulepack/commit/0d0168464a5d35cf61dc755cde0646c74ebea70c) - added policy ecc-aws-097-network_access_control_lists_changes_alarm_exists
- [`e664fca`](https://github.com/epam/ecc-aws-rulepack/commit/e664fcaeb0cc0af5a5e84ad23a2c4f3ffe90a56e) - added policy ecc-aws-100-vpc_changes_alarm_exists
- [`4e3e5ff`](https://github.com/epam/ecc-aws-rulepack/commit/4e3e5ff82d4cc11ccf707f7818c3ba3d7a4e43fe) - added policy ecc-aws-096-security_group_changes_alarm_exists
- [`8ce9cd5`](https://github.com/epam/ecc-aws-rulepack/commit/8ce9cd5e362869597bfc0b0626141602c96f910f) - added policy ecc-aws-078-root_usage_alarm_exists
- [`cc9c290`](https://github.com/epam/ecc-aws-rulepack/commit/cc9c2908ef4aef93bdff133fe5e8cd93ce14f8a9) - added policy ecc-aws-098-network_gateways_changes_alarm_exists
- [`bac0064`](https://github.com/epam/ecc-aws-rulepack/commit/bac00644205bf2cd04e7874ff6c70f8391c9f47a) - added policy ecc-aws-099-route_table_changes_alarm_exists
- [`dfd9278`](https://github.com/epam/ecc-aws-rulepack/commit/dfd9278963a9a79b4b12b3dea0d29b0f99fd2ea4) - added policy ecc-aws-595-reserved_redshift_node_payment_failed
- [`897fbc2`](https://github.com/epam/ecc-aws-rulepack/commit/897fbc2b04cb21d09a493665a42081d30772cce7) - added policy ecc-aws-596-reserved_redshift_node_payment_pending
- [`33a6486`](https://github.com/epam/ecc-aws-rulepack/commit/33a648694548e22676f4d82a15141f8d2167b416) - added policy ecc-aws-587-elasticsearch_reserved_instance_payment_failed
- [`004e5ea`](https://github.com/epam/ecc-aws-rulepack/commit/004e5ea15f3178917460bacdff8b99fba3e2507f) - added policy ecc-aws-588-elasticsearch_reserved_instance_payment_pending
- [`7ac3dee`](https://github.com/epam/ecc-aws-rulepack/commit/7ac3deee368350d593ee1ed96443cb0d3f2ab95f) - added policy ecc-aws-592-reserved_rds_instance_payment_pending
- [`092f994`](https://github.com/epam/ecc-aws-rulepack/commit/092f994a486c00f5519d274b781cd7138178afc7) - added policy ecc-aws-589-elasticsearch_reserved_instance_recent_purchases
- [`a47b972`](https://github.com/epam/ecc-aws-rulepack/commit/a47b972645c86df636563e4b0f94f744a5bde0f1) - added policy ecc-aws-593-reserved_rds_instance_recent_purchases
- [`ce87620`](https://github.com/epam/ecc-aws-rulepack/commit/ce87620cbaf92b3b930086bef8c916adcd5879a4) - added policy ecc-aws-597-reserved_redshift_node_recent_purchases

### :wrench: Updates
- [`63631e0`](https://github.com/epam/ecc-aws-rulepack/commit/63631e08fa5214e80abcd2ec206dea675620813f) - updated policy 499
- [`ee05e81`](https://github.com/epam/ecc-aws-rulepack/commit/ee05e81740a4341fdfa38ea44e5d5c5859a2d641) - updated policies 040, 283, 310, 434, 461, 508
- [`a638744`](https://github.com/epam/ecc-aws-rulepack/commit/a6387443e53c5b1303174d766245efcaed34e80b) - split permissions into two files
- [`0dd9539`](https://github.com/epam/ecc-aws-rulepack/commit/0dd95395d6fa21081eb66d2251452979e3ae2717) - updated a number of policies (see the list in the commit message)
- [`a1f8c6a`](https://github.com/epam/ecc-aws-rulepack/commit/a1f8c6a7bbe8b6475b8ca5b590e3fcaeeaca9d67) - updated policies 272, 283, 310, 461, 497, 508

### :adhesive_bandage: Policy Fixes
- [`0047710`](https://github.com/epam/ecc-aws-rulepack/commit/004771060f863bce9b6f52713e06a9dce5f20755) - fixed policy ecc-aws-258-emr_at_rest_and_in_transit_encryption_enabled
- [`b2bd85e`](https://github.com/epam/ecc-aws-rulepack/commit/b2bd85e3b4bcd3c41e9f7152c6881642e48ab2d9) - fixed policy 258

### :adhesive_bandage: Terraform Fixes
- [`ca732c4`](https://github.com/epam/ecc-aws-rulepack/commit/ca732c49d77cc27b7194d14c38eb6b9651dba50e) - fixed terraform for policy ecc-aws-258-emr_at_rest_and_in_transit_encryption_enabled
- [`3910835`](https://github.com/epam/ecc-aws-rulepack/commit/39108353f756dacd1abbaef92b9bc4f369236c7c) - fixed terraform for policy 258
- [`5efb4ac`](https://github.com/epam/ecc-aws-rulepack/commit/5efb4ac3735118beb8c0399d28addfc35166f651) - fixed terraforms for policies 040, 283, 310, 434, 461
- [`001a77f`](https://github.com/epam/ecc-aws-rulepack/commit/001a77ff7d7666c9d1194b3fa504994d5e1d62b6) - fixed terraform for policies 052, 127, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 304, 305, 306, 307, 362, 394, 425, 444, 446, 447, 448, 508

### :adhesive_bandage: Test Fixes
- [`e3ad0f1`](https://github.com/epam/ecc-aws-rulepack/commit/e3ad0f14d589f6f021f4a77e079997e71ae4bb26) - fixed tests for policy 258
- [`5e27957`](https://github.com/epam/ecc-aws-rulepack/commit/5e2795726dd2973865e317ae07a3b7503d50ed8f) - fixed tests for policies 040, 283, 310, 434, 461, 508


## [v3.0] - 2023-09-20
### :sparkles: New Policies
- [`9f014d6`](https://github.com/epam/ecc-aws-rulepack/commit/9f014d6d7b9d632892456a9fb8c2f43734bc8e4c) - added policy ecc-aws-547-rds_instance_generation
- [`11ef8ce`](https://github.com/epam/ecc-aws-rulepack/commit/11ef8ce13557dccc76af9693326baa893eafa047) - added policy ecc-aws-552-dynamodb_tables_unused
- [`f0dc7d1`](https://github.com/epam/ecc-aws-rulepack/commit/f0dc7d1321cd1c34586d2552897b0e09e07e4cf9) - added policy ecc-aws-553-unused_clb
- [`cbe41ca`](https://github.com/epam/ecc-aws-rulepack/commit/cbe41ca2a68cf43525709844f48b2181a9ac589b) - added policy ecc-aws-560-unused_sns_topic

### :wrench: Updates
- [`1fb3342`](https://github.com/epam/ecc-aws-rulepack/commit/1fb334233bd44fe3defe0833a7a8962da1533338) - added index(comment) to all rules
- [`0b6311c`](https://github.com/epam/ecc-aws-rulepack/commit/0b6311cfbd74f232d3471af356ec65964b7f9fb4) - updated policy ecc-aws-548-ebs_volumes_are_of_type_gp3_instead_of_gp2
- [`ea93aa3`](https://github.com/epam/ecc-aws-rulepack/commit/ea93aa3645cf7a02fe5ff102af164e5a54f65021) - updated comment field for all policies
- [`cd33519`](https://github.com/epam/ecc-aws-rulepack/commit/cd33519fb70c65c1bf042e790410ca494979be93) - updated policy 043

### :adhesive_bandage: Policy Fixes
- [`595a1b0`](https://github.com/epam/ecc-aws-rulepack/commit/595a1b008035836ab7bf40de5ffc069eb71ca238) - fixed policy 298


## [v2.0] - 2023-08-21
### :sparkles: New Policies
- [`b54d258`](https://github.com/epam/ecc-aws-rulepack/commit/b54d2585b6c5ed5c248e984b1e56d4600ef36804) - added non compatible policies (see the list in the commit message)
- [`5e4393b`](https://github.com/epam/ecc-aws-rulepack/commit/5e4393b696405a1df10948e21d769ca5258ecf4d) - added a number of terraform files for policies (see the list in the commit message)
- [`3e9aed2`](https://github.com/epam/ecc-aws-rulepack/commit/3e9aed26e5cd52269a4dfff1178811d0bc5e27e9) - added policy ecc-aws-807-unused_efs_filesystem
- [`4d48faf`](https://github.com/epam/ecc-aws-rulepack/commit/4d48fafe6e7f7078871e23518357d7e4c01ef987) - added policy ecc-aws-1005-ebs_volumes_too_old_snapshots
- [`737f6e8`](https://github.com/epam/ecc-aws-rulepack/commit/737f6e8e04a086940c8b3ce9d62fdeca3e565a08) - added policy ecc-aws-526-waf_global_rulegroup_not_empty *(commit by [@anna-shcherbak](https://github.com/anna-shcherbak))*
- [`075a903`](https://github.com/epam/ecc-aws-rulepack/commit/075a90393bbe3e3cbf14078d43571e906dadb03a) - added policy ecc-aws-529-ebs_attached_volume_delete_on_termination_enabled *(commit by [@anna-shcherbak](https://github.com/anna-shcherbak))*
- [`e7208b3`](https://github.com/epam/ecc-aws-rulepack/commit/e7208b304eaebdb900829062755c00f179a98d8c) - added policy ecc-aws-543-cloudfront_realtime_logging_enabled *(commit by [@anna-shcherbak](https://github.com/anna-shcherbak))*
- [`ad35d4c`](https://github.com/epam/ecc-aws-rulepack/commit/ad35d4c92254ef057917581d3ccf50dd27f64336) - added policy ecc-aws-546-kinesis_streams_retention_period_set_correctly *(commit by [@anna-shcherbak](https://github.com/anna-shcherbak))*
- [`5810523`](https://github.com/epam/ecc-aws-rulepack/commit/58105237039362f3cddc5af8e5acd0c40cf59ec7) - added policy ecc-aws-548-ebs_volumes_are_of_type_gp3_instead_of_gp2

### :wrench: Updates
- [`84be271`](https://github.com/epam/ecc-aws-rulepack/commit/84be27105e5bc79d17de588e4081b417fad728e6) - re-index all policies *(commit by [@anna-shcherbak](https://github.com/anna-shcherbak))*

### :adhesive_bandage: Terraform Fixes
- [`5dd197c`](https://github.com/epam/ecc-aws-rulepack/commit/5dd197cc3b2ff431a17b1fdc84b60f983656004a) - fixed a number of terraform files for policies (see the list in the commit message)

### :adhesive_bandage: Test Fixes
- [`a9870e4`](https://github.com/epam/ecc-aws-rulepack/commit/a9870e4dc3a7852bc0bf1ceb620104880c47fdfb) - fixed tests for policy 490 *(commit by [@anna-shcherbak](https://github.com/anna-shcherbak))*
- [`e54a209`](https://github.com/epam/ecc-aws-rulepack/commit/e54a209e9c5cb5f84d3e9fd5fd928e24d75188e5) - fixed tests for policy 111 *(commit by [@anna-shcherbak](https://github.com/anna-shcherbak))*

### :memo: Documentation Changes
- [`55363ec`](https://github.com/epam/ecc-aws-rulepack/commit/55363ec708eb954556b934663f46a2c78e27ff86) - added README.md for non-compatible-policies


## [v1.0] - 2023-07-12
### :open_file_folder: Initial version


[v1.0]: https://github.com/epam/ecc-aws-rulepack/compare/Init...v1.0

[v2.0]: https://github.com/epam/ecc-aws-rulepack/compare/v1.0...v2.0
[v3.0]: https://github.com/epam/ecc-aws-rulepack/compare/v2.0...v3.0
[v4.0]: https://github.com/epam/ecc-aws-rulepack/compare/v3.0...v4.0
[v5.0]: https://github.com/epam/ecc-aws-rulepack/compare/v4.0...v5.0