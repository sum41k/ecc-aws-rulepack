Registering domain requires manual steps and each domain costs at least $3.
For these reasons, two domains (green and red) were created outside of this terraform configuration.

For policies: 
ecc-aws-128-expired_route53_domain_names (no red)
ecc-aws-342-route53_domain_automatic_renewal_enabled
ecc-aws-344-route53_domain_expires_in_30_days (no red)
ecc-aws-357-route53_transfer_lock_enabled

Green domain name: autotest-r53domain-green.click
Red domain name: autotest-r53domain-red.click
They have tags:
ComplianceStatus = Green/Red
Owner = c7n-ci
ResourceType = r53domain


