resource "aws_ecs_cluster" "this" {
  name = "582_ecs_cluster_red"
}

resource "aws_ecs_task_definition" "this" {
  family                   = "582_ecs_task_definition_red"
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["EC2"]
  runtime_platform {
    operating_system_family = "LINUX"
  }
  execution_role_arn = aws_iam_role.this.arn
  task_role_arn      = aws_iam_role.this.arn


  container_definitions = <<DEFINITION
[
  {
    "name": "sample-app",
    "image":  "httpd:2.4",
    "entryPoint": ["sh", "-c"],
    "command": [
      "/bin/sh -c \"echo \\\"<html> <head> <title>Amazon ECS Sample App</title> <style>body {margin-top: 40px; background-color: #333;} </style> </head></html>\\\" >  /usr/local/apache2/htdocs/index.html && httpd-foreground\""
    ],
    "essential": true,
    "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80,
          "protocol": "tcp"
        }
    ],
    "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "/ecs/${aws_ecs_cluster.this.name}",
                    "awslogs-region": "${var.default-region}",
                    "awslogs-stream-prefix": "ecs"
                }
            }
  }
]
DEFINITION
}

resource "time_sleep" "wait_60_seconds" {
  depends_on      = [aws_autoscaling_group.this]
  create_duration = "60s"
}


resource "aws_ecs_service" "this" {
  name                = "582_ecs_service_red"
  cluster             = aws_ecs_cluster.this.id
  task_definition     = aws_ecs_task_definition.this.arn
  desired_count       = 1
  launch_type         = "EC2"
  scheduling_strategy = "REPLICA"
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }
  ordered_placement_strategy {
    type  = "random"
  }
  ordered_placement_strategy {
    type  = "spread"
    field = "host"
  }
  depends_on = [aws_iam_role_policy_attachment.this, time_sleep.wait_60_seconds]
}

resource "aws_cloudwatch_log_group" "this" {
  name = "/ecs/${aws_ecs_cluster.this.name}"
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = [aws_ecs_capacity_provider.this.name]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 1
    capacity_provider = aws_ecs_capacity_provider.this.name
  }
}

resource "aws_ecs_capacity_provider" "this" {
  name = "${aws_ecs_cluster.this.name}-capacity_provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.this.arn
    managed_termination_protection = "DISABLED"
    managed_scaling {
      maximum_scaling_step_size = 1
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
      instance_warmup_period    = 300
    }
  }
}
