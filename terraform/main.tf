provider "aws" {
  region = "us-east-1"
}

# INTENTIONAL IAC MISCONFIGURATIONS FOR CHECKOV TESTING

# 1. Unencrypted S3 Bucket with Public Read Access
resource "aws_s3_bucket" "vulnerable_bucket" {
  bucket = "devsecops-pipeline-insecure-logging-bucket"
}

resource "aws_s3_bucket_public_access_block" "vulnerable_bucket_access" {
  bucket = aws_s3_bucket.vulnerable_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# 2. Overly Permissive Security Group (Open SSH to World)
resource "aws_security_group" "vulnerable_sg" {
  name        = "open-ssh-security-group"
  description = "Security group with unrestricted inbound access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
