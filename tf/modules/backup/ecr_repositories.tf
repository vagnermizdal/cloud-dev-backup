resource "aws_ecr_repository" "lambda_backup" {
  name = "lambda-backup"
  force_delete = true
}
