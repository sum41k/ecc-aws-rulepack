from datetime import datetime, timedelta, timezone

class PolicyTest(object):

    def test_resources(self, base_test, resources):
        base_test.assertEqual(len(resources), 1)
        if 'LastAccessedDate' in resources[0]:
            LastAccessedDate=datetime.fromisoformat(str(resources[0]['LastAccessedDate']))
            time_now=datetime.fromisoformat('2021-11-03T02:00:00+00:00')
            datatime90ago=time_now-timedelta(days=90)
            base_test.assertFalse(LastAccessedDate>datatime90ago)
        else:
            base_test.assertNotIn('LastAccessedDate',resources[0])
