resource "null_resource" "push_lambda_backup" {
  depends_on = [aws_ecr_repository.lambda_backup]

  provisioner "local-exec" {
    command = "docker build -t lambda-backup:${var.lambda_backup_version} ${path.root}/../../microservices/lambda-backup"
  }

  provisioner "local-exec" {
    command = "docker tag lambda-backup:${var.lambda_backup_version} ${aws_ecr_repository.lambda_backup.repository_url}:${var.lambda_backup_version}"
  }

  provisioner "local-exec" {
    command = "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${aws_ecr_repository.lambda_backup.repository_url}"
  }

  provisioner "local-exec" {
    command = "docker push ${aws_ecr_repository.lambda_backup.repository_url}:${var.lambda_backup_version}"
  }

  triggers = {
    version = var.lambda_backup_version
  }
  
}
