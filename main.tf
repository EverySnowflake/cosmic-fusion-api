# API

module "cosmic_fusion_api" {
  source   = "./modules/api"
  api_name = "${var.api_name}_${var.env}"
}

# GET Profile

module "get_profile_lambda" {
  source                 = "./modules/lambda"
  lambda_zip_file        = "${var.env}GetProfile.zip"
  function_name          = "${var.env}GetProfile"
  handler                = "getProfile.handler"
  runtime                = "nodejs12.x"
  rest_api_execution_arn = module.cosmic_fusion_api.execution_arn
  lambda_bucket          = var.lambda_bucket
  env                    = var.env
}

module "get_profile_endpoint" {
  source               = "./modules/endpoints"
  http_method          = "GET"
  authorization        = "NONE"
  path_part            = "getprofile"
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
  lambda_zip_file        = "${var.env}GetYear.zip"
  function_name          = "${var.env}GetYear"
  handler                = "getYear.handler"
  runtime                = "nodejs12.x"
  rest_api_execution_arn = module.cosmic_fusion_api.execution_arn
  lambda_bucket          = var.lambda_bucket
  env                    = var.env
}

module "get_year_endpoint" {
  source               = "./modules/endpoints"
  http_method          = "GET"
  authorization        = "NONE"
  path_part            = "getyear"
  query_string_a       = "date"
  query_string_b       = "sex_at_birth"
  query_string_c       = false
  query_string_d       = false
  rest_api_id          = module.cosmic_fusion_api.id
  root_resource_id     = module.cosmic_fusion_api.root_resource_id
  lambda_function_name = module.get_year_lambda.function_name
  lambda_invoke_arn    = module.get_year_lambda.invoke_arn
}

module "domain_deployment" {
  source          = "./modules/domain_deployment"
  rest_api_id     = module.cosmic_fusion_api.id
  stage_name      = var.env
  domain_name     = var.domain_name
  certificate_arn = var.certificate_arn
}

#GET celebs

module "get_celebs_lambda" {
  source                 = "./modules/lambda"
  lambda_zip_file        = "${var.env}GetCelebs.zip"
  function_name          = "${var.env}GetCelebs"
  handler                = "getCelebs.handler"
  runtime                = "nodejs12.x"
  rest_api_execution_arn = module.cosmic_fusion_api.execution_arn
  lambda_bucket          = var.lambda_bucket
  env                    = var.env
}

module "get_celebs_endpoint" {
  source               = "./modules/endpoints"
  http_method          = "GET"
  authorization        = "NONE"
  path_part            = "getcelebs"
  query_string_a       = false
  query_string_b       = false
  query_string_c       = false
  query_string_d       = false
  rest_api_id          = module.cosmic_fusion_api.id
  root_resource_id     = module.cosmic_fusion_api.root_resource_id
  lambda_function_name = module.get_celebs_lambda.function_name
  lambda_invoke_arn    = module.get_celebs_lambda.invoke_arn
}

