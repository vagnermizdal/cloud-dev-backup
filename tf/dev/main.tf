provider "aws" {
  region = "us-east-1"
}

module "backup" {
  source = "../modules/backup"
  lambda_backup_version = "v0.0.1"
  original_bucket = "dev-cloud-files-rkiqftjwreyoue"
  backup_bucket = "dev-cloud-files-rkiqftjwreyoue-bkp"
}
