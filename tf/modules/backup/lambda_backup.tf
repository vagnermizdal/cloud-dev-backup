resource "aws_lambda_function" "lambda_backup" {
  function_name = "lambda-backup"
  package_type  = "Image"
  memory_size   = 512
  image_uri     = "${aws_ecr_repository.lambda_backup.repository_url}:${var.lambda_backup_version}"
  role          = aws_iam_role.lambda_backup.arn
  timeout       = 30
  # layers = [
  #   "arn:aws:lambda:us-east-1:553035198032:layer:git-lambda2:8"
  # ]

  ephemeral_storage {
    size = 512
  }

  environment {
    variables = {
      BUCKET_ORIGINAL = aws_s3_bucket.original_repo.id
      BUCKET_BACKUP   = aws_s3_bucket.backup_repo.id
    }
  }

  tracing_config {
    mode = "Active"
  }

  depends_on = [null_resource.push_lambda_backup]
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_backup.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.original_repo.arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.original_repo.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda_backup.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}
