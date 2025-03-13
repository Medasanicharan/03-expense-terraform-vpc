terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.82.2"
    }
  }
  backend "s3" {
    bucket = "daws78s.xyz-remote-state1"
    key    = "expense-dev-vpc"
    region = "us-east-1"
    dynamodb_table = "daws78s.xyz-locking-demo"
  }

}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}