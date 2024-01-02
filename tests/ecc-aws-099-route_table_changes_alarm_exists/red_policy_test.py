from botocore.exceptions import ClientError

class PolicyTest(object):

    def test_resources_with_client(self, base_test, resources, local_session):
        base_test.assertEqual(len(resources), 1)

        trail_client = local_session.client("cloudtrail")
        trail_name = "c7n-099-cloudtrail-red"
        describe_trails = trail_client.describe_trails(trailNameList=[trail_name])
        base_test.assertFalse(describe_trails["trailList"][0]["IsMultiRegionTrail"])
        base_test.assertTrue(describe_trails["trailList"][0]["IncludeGlobalServiceEvents"])

        trail_status = trail_client.get_trail_status(Name=trail_name)
        base_test.assertTrue(trail_status["IsLogging"])

        event_selectors = trail_client.get_event_selectors(TrailName=trail_name)
        for FieldSelectors in event_selectors["AdvancedEventSelectors"][0]["FieldSelectors"]:
          base_test.assertEqual(FieldSelectors["Field"], "eventCategory")
          base_test.assertIn("Management", FieldSelectors["Equals"])
          base_test.assertNotEqual(FieldSelectors["Field"], "readOnly")

        logs_client = local_session.client("logs")
        try:
          logs_metrics = logs_client.describe_metric_filters(logGroupName="099_log_group_red")
        except ClientError as e:
          base_test.assertEqual(e.response['Error']['Code'],"ResourceNotFoundException")