resource "aws_ecs_cluster" "website_cluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "website_task" {
  family                   = "website-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = <<DEFINITION
[
  {
    "name": "${var.container_name}",
    "image": "${var.container_image}",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
DEFINITION
}

resource "aws_ecs_service" "website_service" {
  name            = "website-service"
  cluster         = aws_ecs_cluster.website_cluster.id
  task_definition = aws_ecs_task_definition.website_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.website_tg.arn
    container_name   = var.container_name
    container_port   = 80
  }
}

resource "aws_lb_target_group" "website_tg" {
  name        = "website-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
  }
}