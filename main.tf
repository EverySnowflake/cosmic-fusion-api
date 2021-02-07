module "cosmic_fusion_api" {
  source = "./modules/api"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = module.cosmic_fusion_api.id
  parent_id   = module.cosmic_fusion_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxyMethod" {
  rest_api_id   = module.cosmic_fusion_api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id             = module.cosmic_fusion_api.id
  resource_id             = aws_api_gateway_method.proxyMethod.resource_id
  http_method             = aws_api_gateway_method.proxyMethod.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = ""
}

module "lambda" {
  source          = "./modules/lambda"
  lambda_zip_file = var.lambda_zip_file
  handler         = var.handler
  runtime         = "nodejs12.x"
}

module "get_profile" {
  source                  = "./modules/endpoints"
  rest_api_id             = module.cosmic_fusion_api.id
  resource_id             = module.cosmic_fusion_api.root_resource_id
  integration_http_method = "GET"
  universal_integration   = aws_api_gateway_integration.lambda
  stage_name              = "test"
  lambda_function_name    = module.lambda.function_name
  rest_api_execution_arn  = module.cosmic_fusion_api.execution_arn
}
