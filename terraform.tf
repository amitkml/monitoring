terraform {
  backend s3 {
    bucket = "brutalismbot"
    key    = "terraform/monitoring.tfstate"
    region = "us-east-1"
  }

  required_version = ">= 0.12.0"
}

provider aws {
  version = "~> 2.7"
}

resource aws_cloudwatch_dashboard dash {
  dashboard_name = "Brutalismbot"
  dashboard_body = file("dashboard.json")
}
