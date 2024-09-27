terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.68.0"
    }
  }
  backend "s3" {
    bucket = "mys3bucket-remote-state"
    key = "for-vpc-infra"
    region = "us-east-1"
    dynamodb_table = "demo-table-locking"
  }
}

provider "aws" {
  region = "us-east-1"
}