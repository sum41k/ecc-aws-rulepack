class PolicyTest(object):

    def test_resources_with_client(self, base_test, resources, local_session):
        base_test.assertEqual(len(resources), 1)

        trail_client = local_session.client("cloudtrail")
        trail_name = "c7n-079-cloudtrail-red"
        describe_trails = trail_client.describe_trails(trailNameList=[trail_name])
        base_test.assertFalse(describe_trails["trailList"][0]["IsMultiRegionTrail"])
        base_test.assertTrue(describe_trails["trailList"][0]["IncludeGlobalServiceEvents"])

        trail_status = trail_client.get_trail_status(Name=trail_name)
        base_test.assertTrue(trail_status["IsLogging"])

        event_selectors = trail_client.get_event_selectors(TrailName=trail_name)
        base_test.assertEqual(event_selectors["EventSelectors"][0]["ReadWriteType"], "All")
        base_test.assertTrue(event_selectors["EventSelectors"][0]["IncludeManagementEvents"])

        logs_client = local_session.client("logs")
        logs_metrics = logs_client.describe_metric_filters(logGroupName="079_log_group_red")
        base_test.assertEqual(logs_metrics["metricFilters"], [])
