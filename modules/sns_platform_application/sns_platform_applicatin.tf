resource "aws_sns_platform_application" "platform_application" {
  name                = var.name
  platform            = var.platform
  platform_credential = var.platform_credential
}