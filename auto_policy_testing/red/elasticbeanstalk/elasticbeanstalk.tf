resource "aws_elastic_beanstalk_application" "this" {
  name        = "${module.naming.resource_prefix.beanstalk}"
  description = "${module.naming.resource_prefix.beanstalk}"
}

resource "aws_elastic_beanstalk_environment" "this" {
  provider            = aws.provider2
  name                = "${module.naming.resource_prefix.beanstalk_env}"
  application         = aws_elastic_beanstalk_application.this.name
  solution_stack_name = "64bit Amazon Linux 2 v3.3.7 running Python 3.8"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "basic"
  }
}
