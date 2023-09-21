class PolicyTest(object):

    def test_resources(self, base_test, resources):
        base_test.assertEqual(len(resources), 1)
        base_test.assertEqual(resources[0]["c7n.metrics"]["AWS/NATGateway.BytesOutToDestination.Average.7"][0]["Average"], 0.0)
        base_test.assertEqual(resources[0]["State"],"available")
