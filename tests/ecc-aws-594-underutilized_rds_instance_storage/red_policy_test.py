class PolicyTest(object):

     def test_resources_with_client(self, base_test, resources, local_session):
         base_test.assertEqual(len(resources), 1)
         client = local_session.client('cloudwatch')
         instance_id = resources[0]["DBInstanceIdentifier"]
         free_storage_datapoints = client.get_metric_statistics(Namespace = "AWS/RDS", MetricName = "FreeStorageSpace", StartTime = "2023-09-19T12:18:00Z", EndTime = "2023-09-20T12:18:00Z", Period = 3600, Dimensions = [{'Name': 'DBInstanceIdentifier', 'Value': instance_id}])
         for free_storage_datapoint in free_storage_datapoints["Datapoints"]:
         	total_storage = resources[0]["AllocatedStorage"] * 1073741824
         	percent = free_storage_datapoint["Maximum"] / total_storage * 100
         	base_test.assertGreaterEqual(free_storage_datapoint["Maximum"], 85)
