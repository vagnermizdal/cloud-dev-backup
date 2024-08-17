# cloud-dev-backup

### Test Project with Cloud Environment on AWS

In this project, I use the AWS cloud infrastructure to perform automated file operations.

When a file is uploaded to an Amazon S3 bucket, a cloud function (AWS Lambda) is automatically activated. This function is responsible for processing the sent file, creating a backup copy in a separate Amazon S3 bucket.

This process ensures that the original file is duplicated and stored securely, allowing for data recovery and protection against information loss.