terraform {

  backend "s3" {
    bucket = "testing-migrate-raunaq"
    key    = "terraform-states/migrate-repo/terraform.tfstate"
    region = "eu-north-1"
  }
  required_providers {
    aws = {
      version = ">= 5.39.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_iam_role" "very-secure-role" {
  name = "very-secure-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    createdBy     = "terraform"
    terraformTime = "${timestamp()}"
    CanDelete     = "true"
    product       = "credit-boost"
  }
}
# This is the git root