resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = var.rest_api_id
  stage_name  = var.stage_name
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_domain_name" "domain" {
  domain_name     = var.domain_name
  certificate_arn = var.certificate_arn
}

resource "aws_api_gateway_base_path_mapping" "domain_mapping" {
  api_id      = var.rest_api_id
  domain_name = aws_api_gateway_domain_name.domain.domain_name
  stage_name  = var.stage_name
}