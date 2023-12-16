class PolicyTest(object):

    def test_resources_with_client(self, base_test, resources, local_session):
        sts_client = local_session.client("sts").get_caller_identity()
        organization_client = local_session.client("organizations").describe_organization()
        base_test.assertEqual(sts_client['Account'], organization_client['Organization']['MasterAccountId'])
        base_test.assertIn('Id', organization_client['Organization'])

        trail_client = local_session.client("cloudtrail")
        trail_describe=trail_client.describe_trails()        
        base_test.assertTrue(trail_describe["trailList"][0]["IsMultiRegionTrail"])
        base_test.assertTrue(trail_describe["trailList"][0]["IsMultiRegionTrail"])
        base_test.assertTrue(trail_describe["trailList"][0]["IncludeGlobalServiceEvents"])
        
        trail_status = trail_client.get_trail_status(Name=trail_describe["trailList"][0]['Name'])
        base_test.assertFalse(trail_status["IsLogging"])
        
        event_selectors = trail_client.get_event_selectors(TrailName=trail_describe["trailList"][0]['Name'])
        base_test.assertEqual(event_selectors["EventSelectors"][0]["ReadWriteType"], "All")
        base_test.assertTrue(event_selectors["EventSelectors"][0]["IncludeManagementEvents"])
        
        
        sns_client = local_session.client("sns")
        subscriptions = sns_client.get_topic_attributes(TopicArn = "arn:aws:sns:us-east-1:644160668196:145-sns-green")['Attributes']['SubscriptionsConfirmed']
        base_test.assertEqual('0', subscriptions)
