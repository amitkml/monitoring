#################
#   TERRAFORM   #
#################

terraform {
  required_version = "~> 1.0"

  cloud {
    organization = "brutalismbot"

    workspaces { name = "monitoring" }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

###########
#   AWS   #
###########

provider "aws" {
  region = "us-west-2"
  assume_role { role_arn = var.AWS_ROLE_ARN }
  default_tags { tags = local.tags }
}

#################
#   VARIABLES   #
#################

variable "AWS_ROLE_ARN" {}

##############
#   LOCALS   #
##############

locals {
  tags = {
    App  = "Brutalismbot"
    Name = "Brutalismbot"
    Repo = "https://github.com/brutalismbot/monitoring"
  }
}


############################
#   CLOUDWATCH DASHBOARD   #
############################

resource "aws_cloudwatch_dashboard" "dash" {
  dashboard_name = "Brutalismbot"
  dashboard_body = file("${path.module}/dashboard.json")
}
