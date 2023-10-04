data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "this" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name   = "availability-zone"
    values = [data.aws_availability_zones.this.names[0]]
  }
}

data "aws_availability_zones" "this" {
  state = "available"
}

resource "aws_launch_template" "this" {
  name_prefix   = "601_launch_template_green"
  image_id      = data.aws_ami.this.id
  instance_type = "t2.micro"
}

data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_autoscaling_group" "this" {
  name                = "601-autoscaling_group-green"
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = [data.aws_subnets.this.ids[0]]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tag {
    key                 = "CustodianRule"
    value               = "ecc-aws-601-autoscaling_groups_capacity_rebalancing_enabled"
    propagate_at_launch = true
  }

  tag {
    key                 = "ComplianceStatus"
    value               = "Green"
    propagate_at_launch = true
  }
}