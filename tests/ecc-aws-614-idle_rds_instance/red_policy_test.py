class PolicyTest(object):

     def test_resources_with_client(self, base_test, resources, local_session):
         base_test.assertEqual(len(resources), 1)
         client = local_session.client('cloudwatch')
         instance_id = resources[0]["DBInstanceIdentifier"]
         connection_datapoints = client.get_metric_statistics(Namespace = "AWS/RDS", MetricName = "DatabaseConnections", StartTime = "2023-09-27T08:19:00Z", EndTime = "2023-09-28T08:19:00Z", Period = 3600, Dimensions = [{'Name': 'DBInstanceIdentifier', 'Value': instance_id}])
         for connection_datapoint in connection_datapoints["Datapoints"]:
         	base_test.assertEqual(connection_datapoint["Maximum"], 0)
