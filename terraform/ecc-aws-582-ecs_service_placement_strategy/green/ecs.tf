resource "aws_ecs_cluster" "this" {
  name = "582_ecs_cluster_green"
}

resource "aws_ecs_task_definition" "this" {
    family                   = "service"
    cpu                      = 256
    memory                   = 512
    requires_compatibilities = ["FARGATE"]
    network_mode             = "awsvpc"
    container_definitions = <<DEFINITION
[
  {
    "name": "web",
    "image": "nginx",
    "cpu": 256,
    "memory": 512
  }
]
DEFINITION
}

resource "aws_ecs_service" "this" {
  name             = "582_ecs_service_green"
  launch_type      = "FARGATE"
  cluster          = aws_ecs_cluster.this.id
  task_definition  = aws_ecs_task_definition.this.arn
  desired_count    = 1
  platform_version = "LATEST"

  network_configuration {
    security_groups  = [aws_security_group.this.id]
    subnets          = [data.aws_subnets.this.ids[0]]
    assign_public_ip = false
  }
}
