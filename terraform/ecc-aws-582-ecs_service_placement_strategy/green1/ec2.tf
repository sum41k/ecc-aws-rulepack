data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_iam_instance_profile" "ecs_agent" {
  name = "582-ecs-agent-green1"
  role = aws_iam_role.ecs_agent.name
}

resource "aws_launch_template" "this" {
  name                                 = "582_ec2_launch_template_green1"
  image_id                             = data.aws_ami.this.id
  instance_type                        = "t2.micro"
  instance_initiated_shutdown_behavior = "terminate"
  user_data                            = base64encode("#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.this.name} >> /etc/ecs/ecs.config")
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      delete_on_termination = true
      volume_size           = 30
      volume_type           = "gp2"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_agent.name
  }
  network_interfaces {
    associate_public_ip_address = true
    device_index                = 0
    subnet_id                   = data.aws_subnets.this.ids[0]
    security_groups             = [aws_security_group.this.id]
    delete_on_termination       = true
  }
  placement {
    availability_zone = data.aws_availability_zones.this.names[0]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "582_instance_green1"
    }
  }

}

resource "aws_autoscaling_group" "this" {
  name               = "582_asg_green1"
  availability_zones = [data.aws_availability_zones.this.names[0]]
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  lifecycle {
    create_before_destroy = true
  }
  desired_capacity          = 1
  min_size                  = 0
  max_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

