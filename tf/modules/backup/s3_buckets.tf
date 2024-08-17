resource "aws_s3_bucket" "original_repo" {
  bucket = var.original_bucket
  force_destroy = true
}

resource "aws_s3_bucket" "backup_repo" {
  bucket = var.backup_bucket
  force_destroy = true
}
