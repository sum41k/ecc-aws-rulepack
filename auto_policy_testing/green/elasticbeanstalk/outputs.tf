output "elasticbeanstalk" {
  value = {
    elasticbeanstalk-environment = aws_elastic_beanstalk_environment.this.arn
  }
}