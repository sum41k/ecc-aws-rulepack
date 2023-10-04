class PolicyTest(object):

    def test_resources(self, base_test, resources):
        base_test.assertEqual(len(resources), 1)
        base_test.assertEqual(resources[0]["MinSize"], resources[0]["MaxSize"])
        base_test.assertEqual(resources[0]["DesiredCapacity"], resources[0]["MaxSize"])
        base_test.assertEqual(resources[0]["DesiredCapacity"], resources[0]["MinSize"])