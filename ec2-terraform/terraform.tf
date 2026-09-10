terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
  bucket         = "terraform-state-bucket-ap-arindam-2026"
  key            = "terraform.tfstate"
  region         = "ap-south-1"
  use_lockfile = "terraform-dynamodb-state-table"
}
}