terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  #profile = "my-tf-profile"
  region     = var.AWS_REGION
  access_key = "AKIATVCFOFHYYTCOQ7UR"
  secret_key = "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"
}