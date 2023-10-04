class PolicyTest(object):

     def test_resources_with_client(self, base_test, resources, local_session):
         base_test.assertEqual(len(resources), 1)
         client = local_session.client('efs')
         id = resources[0]["FileSystemId"]
         client = client.describe_lifecycle_configuration(FileSystemId = id)
         base_test.assertEqual(len(client["LifecyclePolicies"]), 0)