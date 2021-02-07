variable "api_name" {
  default = "cosmic_fusion"
}

variable "type" {
  default = "AWS_PROXY"
}

variable "lambda_zip_file" {
  default = "cosmic_fusion.zip"
}

variable "handler" {
  default = "cosmic_fusion.handler"
}