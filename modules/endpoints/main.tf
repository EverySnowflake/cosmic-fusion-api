resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = var.rest_api_id
  resource_id   = var.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
  
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_method.proxy_root.resource_id
  http_method = aws_api_gateway_method.proxy_root.http_method

  integration_http_method = var.integration_http_method
  type                    = var.type
  uri                     = "aws_lambda_function.myLambda.invoke_arn"
}

resource "aws_api_gateway_deployment" "apideploy" {
  depends_on = [
    var.universal_integration,
    aws_api_gateway_integration.lambda_root,
  ]

  rest_api_id = var.rest_api_id
  stage_name  = var.stage_name
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${var.rest_api_execution_arn}/*/*"
}
