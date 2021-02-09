resource "aws_api_gateway_request_validator" "validator" {
  name                        = var.request_validator_name
  rest_api_id                 = var.rest_api_id
  validate_request_body       = true
  validate_request_parameters = true
}