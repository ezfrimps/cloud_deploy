resource "aws_cloudwatch_log_group" "odoojobs" {
  name = "odoojobs"

  tags {
    Environment = var.environment
    Application = "OdooJobs"
  }
}

resource "aws_ecr_repository" "odoojobs_app" {
  name = var.repository_name
}

resource "aws_ecs_cluster" "cluster" {
  name = "${var.environment}-ecs-cluster"
}

data "template_file" "odoo_task" {
  template = file("${path.module}/tasks/web_task_definition.json")

  vars {
    image           = aws_ecr_repository.openjobs_app.repository_url
    secret_key_base = var.secret_key_base
    database_url    = "postgresql://${var.database_username}:${var.database_password}@${var.database_endpoint}:5432/${var.database_name}?encoding=utf8&pool=40"
    log_group       = aws_cloudwatch_log_group.openjobs.name
  }
}

resource "aws_ecs_task_definition" "web" {
  family                   = "${var.environment}_web"
  container_definitions    = data.template_file.web_task.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_execution_role.arn
}