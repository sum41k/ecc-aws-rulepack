import datetime
from dateutil import tz as tzutil

class PolicyTest(object):

    def mock_time(self):
        return 2019, 2, 26
        
    def test_resources(self, base_test, resources):
        base_test.assertEqual(len(resources), 1)
        base_test.assertEqual(resources[0]['State'], "active")
        start_time = resources[0]["Start"]
        time_now = datetime.datetime.fromisoformat(datetime.datetime.utcnow().replace(tzinfo=datetime.timezone.utc).isoformat())
        delta = start_time - time_now
        base_test.assertTrue(delta.days<=7)