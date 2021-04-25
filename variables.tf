variable "domain_name" {}

variable "env" {}

variable "api_name" {
  default = "cosmic_fusion"
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

variable "engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "5.6"
}

variable "instance_class" {
  default = "db.t3.micro"
}

variable "port" {
  default = 3306
}

variable "maintenance_window" {
  default = "Mon:00:00-Mon:03:00"
}

variable "backup_window" {
  default = "03:00-06:00"
}

variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-9f18d7f6", "subnet-2d00c460", "subnet-0c309c77"]
}

variable "db_family" {
  default = "mysql5.6"
}

variable "api_key" {
  default = ""
}

variable "platform_name" {
  default = "cosmic_fusion_platform_application"
}

variable "platform" {
  default = "GPG"
}