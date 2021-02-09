variable "api_name" {
  default = "cosmic_fusion"
}

variable "type" {
  default = "AWS_PROXY"
}

variable "handler" {
  default = "test.handler"
}

variable "region" {
  default = "eu-west-2"
}

variable "lambda_bucket" {
  default = "cosmic-fusion-lambda"
}