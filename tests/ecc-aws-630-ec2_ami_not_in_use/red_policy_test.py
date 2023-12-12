class PolicyTest(object):

    def test_resources_with_client(self, base_test, resources, local_session):
        base_test.assertEqual(len(resources), 1)
        base_ami = resources[0]['ImageId']
        ami_client = local_session.client("ec2").describe_instances()
        ec2_ami = ami_client['Reservations'][0]['Instances'][0]['ImageId']
        base_test.assertNotEqual(base_ami, ec2_ami)