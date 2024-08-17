resource "aws_iam_role" "lambda_backup" {
  name = "lambda-backup"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_backup" {
  name = "lambda-backup-policy"
  role = aws_iam_role.lambda_backup.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = ["s3:PutObject", "s3:GetObject"],
      Effect = "Allow",
      Resource = [
        aws_s3_bucket.original_repo.arn,
        "${aws_s3_bucket.original_repo.arn}/*"
      ]
    },{
      Action = ["s3:PutObject", "s3:GetObject"],
      Effect = "Allow",
      Resource = [
        aws_s3_bucket.backup_repo.arn,
        "${aws_s3_bucket.backup_repo.arn}/*"
      ]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exec_basic" {
  role       = aws_iam_role.lambda_backup.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
