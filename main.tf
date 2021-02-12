module "cosmic_fusion_api" {
  source   = "./modules/api"
  api_name = var.api_name
}

module "lambda" {
  source                 = "./modules/lambda"
  lambda_zip_file        = "getProfile.zip"
  function_name          = "getProfile"
  handler                = "getProfile.handler"
  runtime                = "nodejs12.x"
  rest_api_execution_arn = module.cosmic_fusion_api.execution_arn
  lambda_bucket          = var.lambda_bucket
}

module "get_profile_request_validator" {
  source                 = "./modules/request_validators"
  request_validator_name = "get_profile"
  rest_api_id            = module.cosmic_fusion_api.id
}

module "get_profile" {
  source               = "./modules/endpoints"
  http_method          = "GET"
  authorization        = "NONE"
  stage_name           = "test"
  path_part            = "getProfile"
  query_string_a       = "dob"
  query_string_b       = "sex_at_birth"
  query_string_c       = false
  query_string_d       = false
  rest_api_id          = module.cosmic_fusion_api.id
  root_resource_id     = module.cosmic_fusion_api.root_resource_id
  lambda_function_name = module.lambda.function_name
  lambda_invoke_arn    = module.lambda.invoke_arn
  request_validator    = module.get_profile_request_validator.id
}
