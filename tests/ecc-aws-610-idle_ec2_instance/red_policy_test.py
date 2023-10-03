class PolicyTest(object):

     def test_resources_with_client(self, base_test, resources, local_session):
         base_test.assertEqual(len(resources), 1)
         client = local_session.client('cloudwatch')
         base_test.assertEqual(resources[0]["State"]["Name"], "running")
         instance_id = resources[0]["InstanceId"]
         cpu_datapoints = client.get_metric_statistics(Namespace = "AWS/EC2", MetricName = "CPUUtilization", StartTime = "2023-09-08T11:40:00Z", EndTime = "2023-09-29T10:40:00Z", Period = 3600, Dimensions = [{'Name': 'InstanceId', 'Value': instance_id}])
         for cpu_datapoint in cpu_datapoints["Datapoints"]:
         	base_test.assertLess(cpu_datapoint["Maximum"], 2)
         	
         networkIn_datapoints = client.get_metric_statistics(Namespace = "AWS/EC2", MetricName = "NetworkIn", StartTime = "2023-09-08T12:55:00Z", EndTime = "2023-09-29T11:55:00Z", Period = 3600, Dimensions = [{'Name': 'InstanceId', 'Value': instance_id}])
         for networkIn_datapoint in networkIn_datapoints["Datapoints"]:
         	base_test.assertLess(networkIn_datapoint["Maximum"], 50000)

         networkIn_datapoints = client.get_metric_statistics(Namespace = "AWS/EC2", MetricName = "NetworkOut", StartTime = "2023-09-08T13:50:00Z", EndTime = "2023-09-29T12:50:00Z", Period = 3600, Dimensions = [{'Name': 'InstanceId', 'Value': instance_id}])
         for networkIn_datapoint in networkIn_datapoints["Datapoints"]:
         	base_test.assertLess(networkIn_datapoint["Maximum"], 50000)