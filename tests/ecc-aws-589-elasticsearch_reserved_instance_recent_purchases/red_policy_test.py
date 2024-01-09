import datetime

class PolicyTest(object):

    def mock_time(self):
        return 2024, 1, 9
        
    def test_resources(self, base_test, resources):
        base_test.assertEqual(len(resources), 1)
        base_test.assertEqual(resources[0]['State'], "active")
        start_time_timestamp = resources[0]["StartTime"]
        start_time = datetime.datetime.fromtimestamp(start_time_timestamp)
        time_now = datetime.datetime.now()
        delta = time_now - start_time
        base_test.assertTrue(delta.days <= 7)