terraform {
  required_version = "~> 1.0"

  backend "s3" {
    bucket = "brutalismbot"
    key    = "terraform/monitoring.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_cloudwatch_dashboard" "dash" {
  dashboard_name = "Brutalismbot"
  dashboard_body = file("dashboard.json")
}
