provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    encrypt = true
    region  = "eu-west-1"
  }
}