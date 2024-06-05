resource "aws_ecr_repository" "barista_repo" {
  name = var.repository_name
}