resource "aws_api_gateway_resource" "resource" {
  path_part   = var.path_part
  parent_id   = var.root_resource_id
  rest_api_id = var.rest_api_id
}

resource "aws_api_gateway_method" "method" {
  rest_api_id          = var.rest_api_id
  resource_id          = aws_api_gateway_resource.resource.id
  http_method          = var.http_method
  authorization        = var.authorization
  request_validator_id = var.request_validator

  request_parameters = {
    "method.request.querystring.${var.query_string_a}" = false
    "method.request.querystring.${var.query_string_b}" = false
    "method.request.querystring.${var.query_string_c}" = false
    "method.request.querystring.${var.query_string_d}" = false
  }
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = var.lambda_invoke_arn
  request_templates = {
    "application/json" = "${data.template_file.mapping_template.rendered}"
  }

  request_parameters = {
    "integration.request.querystring.${var.query_string_a}" = "method.request.querystring.${var.query_string_a}"
    "integration.request.querystring.${var.query_string_b}" = "method.request.querystring.${var.query_string_b}"
    "integration.request.querystring.${var.query_string_c}" = "method.request.querystring.${var.query_string_c}"
    "integration.request.querystring.${var.query_string_d}" = "method.request.querystring.${var.query_string_d}"
  }
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = "200"
  depends_on  = [aws_api_gateway_resource.resource, aws_api_gateway_method.method, aws_api_gateway_integration.integration]
}

resource "aws_api_gateway_integration_response" "integration_response" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code
  depends_on  = [aws_api_gateway_resource.resource, aws_api_gateway_method.method, aws_api_gateway_integration.integration]
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on  = [aws_api_gateway_integration.integration]
  rest_api_id = var.rest_api_id
  stage_name  = "test"
}