terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }
  backend "s3" {
    bucket = "k8s-ec2-remote-state"
    key    = "k8s-workstation-ec2"
    region = "us-east-1"
    dynamodb_table = "k8s-ec2-locking"
  }
}
provider "aws" {
  # Configuration options
  region = "us-east-1"
}

