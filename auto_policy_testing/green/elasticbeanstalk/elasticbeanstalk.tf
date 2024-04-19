resource "aws_elastic_beanstalk_application" "this" {
  name        = "${module.naming.resource_prefix.elastic_beanstalk}"
  description = "${module.naming.resource_prefix.elastic_beanstalk}"
}

resource "aws_elastic_beanstalk_environment" "this" {
  name                = "environment-green"
  application         = aws_elastic_beanstalk_application.this.name
  solution_stack_name = "64bit Amazon Linux 2 v3.3.7 running Python 3.8"

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }
}