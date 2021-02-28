variable "handler" {}

variable "domain_name" {}

variable "env" {}

variable "api_name" {
  default = "cosmic_fusion"
}

variable "type" {
  default = "AWS_PROXY"
}

variable "region" {
  default = "eu-west-2"
}

variable "lambda_bucket" {
  default = "cosmic-fusion-lambda"
}

variable "certificate_arn" {
  default = "arn:aws:acm:us-east-1:901964243946:certificate/f407b73c-5a78-4c25-9688-7d15c2bbee1f"
}