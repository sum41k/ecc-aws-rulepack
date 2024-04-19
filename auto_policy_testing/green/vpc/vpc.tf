resource "aws_flow_log" "this" {
  iam_role_arn    = "${aws_iam_role.this.arn}"
  log_destination = "${aws_cloudwatch_log_group.this.arn}"
  traffic_type    = "REJECT"
  vpc_id          = data.terraform_remote_state.common.outputs.vpc_id
}

resource "aws_cloudwatch_log_group" "this" {
  name = "003_log_group_green"
}

resource "aws_iam_role" "this" {
  name = "003_role_green"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "this" {
  name = "003_policy_green"
  role = "${aws_iam_role.this.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

# 

resource "aws_security_group" "this" {
  name        = "187_security_group_green"
  description = "187_security_group_description_green"
}

resource "aws_vpc_endpoint" "this" {
  vpc_id            = data.terraform_remote_state.common.outputs.vpc_id
  service_name      = "com.amazonaws.us-east-1.ec2"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.this.id,
  ]

  depends_on = [aws_security_group.this]
}
