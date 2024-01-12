import datetime
from dateutil import tz as tzutil

class PolicyTest(object):

    def mock_time(self):
        return 2024, 1, 12
        
    def test_resources(self, base_test, resources):
        base_test.assertEqual(len(resources), 1)
        base_test.assertEqual(resources[0]['State'], "active")
        
        start_time_str = resources[0]["StartTime"]
        start_time = datetime.datetime.strptime(start_time_str, "%Y-%m-%dT%H:%M:%S.%fZ").replace(tzinfo=datetime.timezone.utc)
        
        time_now = datetime.datetime.utcnow().replace(tzinfo=datetime.timezone.utc)
        delta = start_time - time_now
        base_test.assertTrue(delta.days <= 7)