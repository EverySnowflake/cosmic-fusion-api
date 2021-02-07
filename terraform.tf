provider "aws" {
  region  = var.region
  version = "~> 2.0"
}

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "cosmic-fusion-terraform-state"
    key     = "cosmic-fusion-terraform-state.tfstate"
    region  = "eu-west-1"
  }
}