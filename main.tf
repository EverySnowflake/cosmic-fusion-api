# API

module "cosmic_fusion_api" {
  source   = "./modules/api"
  api_name = var.api_name
}

# GET Profile

module "get_profile_lambda" {
  source                 = "./modules/lambda"
  lambda_zip_file        = "getProfile.zip"
  function_name          = "getProfile"
  handler                = "getProfile.handler"
  runtime                = "nodejs12.x"
  rest_api_execution_arn = module.cosmic_fusion_api.execution_arn
  lambda_bucket          = var.lambda_bucket
}

module "get_profile_endpoint" {
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
  lambda_function_name = module.get_profile_lambda.function_name
  lambda_invoke_arn    = module.get_profile_lambda.invoke_arn
}

# GET Year

module "get_year_lambda" {
  source                 = "./modules/lambda"
  lambda_zip_file        = "getYear.zip"
  function_name          = "getYear"
  handler                = "getYear.handler"
  runtime                = "nodejs12.x"
  rest_api_execution_arn = module.cosmic_fusion_api.execution_arn
  lambda_bucket          = var.lambda_bucket
}

module "get_year_endpoint" {
  source               = "./modules/endpoints"
  http_method          = "GET"
  authorization        = "NONE"
  stage_name           = "test"
  path_part            = "getYear"
  query_string_a       = "date"
  query_string_b       = "sex_at_birth"
  query_string_c       = false
  query_string_d       = false
  rest_api_id          = module.cosmic_fusion_api.id
  root_resource_id     = module.cosmic_fusion_api.root_resource_id
  lambda_function_name = module.get_year_lambda.function_name
  lambda_invoke_arn    = module.get_year_lambda.invoke_arn
}
