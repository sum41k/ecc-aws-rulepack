class PolicyTest(object):

     def test_resources_with_client(self, base_test, resources, local_session):
         base_test.assertEqual(len(resources), 1)
         instance_id = resources[0]['Attachments'][0]['InstanceId']
         client = local_session.client('ec2')
         state = client.describe_instances(InstanceIds = [instance_id])['Reservations'][0]['Instances'][0]['State']['Name']
         base_test.assertEqual(state, "stopped")
