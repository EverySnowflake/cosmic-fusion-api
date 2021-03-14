# API

module "cosmic_fusion_api" {
  source   = "./modules/api"
  api_name = "${var.env}_${var.api_name}"
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
  DATABASE_HOST          = trimsuffix(module.rds.endpoint, ":${var.port}")
}

module "get_profile_endpoint" {
  source               = "./modules/endpoints"
  http_method          = "GET"
  authorization        = "NONE"
  path_part            = "get-profile"
  query_string_a       = "dob"
  query_string_b       = "sex_at_birth"
  query_string_c       = false
  query_string_d       = false
  rest_api_id          = module.cosmic_fusion_api.id
  root_resource_id     = module.cosmic_fusion_api.root_resource_id
  lambda_function_name = module.get_profile_lambda.function_name
  lambda_invoke_arn    = module.get_profile_lambda.invoke_arn
  request_models       = null
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
  DATABASE_HOST          = trimsuffix(module.rds.endpoint, ":${var.port}")
}

module "get_year_endpoint" {
  source               = "./modules/endpoints"
  http_method          = "GET"
  authorization        = "NONE"
  path_part            = "get-year"
  query_string_a       = "date"
  query_string_b       = false
  query_string_c       = false
  query_string_d       = false
  rest_api_id          = module.cosmic_fusion_api.id
  root_resource_id     = module.cosmic_fusion_api.root_resource_id
  lambda_function_name = module.get_year_lambda.function_name
  lambda_invoke_arn    = module.get_year_lambda.invoke_arn
  request_models       = null
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
  DATABASE_HOST          = trimsuffix(module.rds.endpoint, ":${var.port}")
}

module "get_celebs_endpoint" {
  source               = "./modules/endpoints"
  http_method          = "GET"
  authorization        = "NONE"
  path_part            = "get-celebs"
  query_string_a       = false
  query_string_b       = false
  query_string_c       = false
  query_string_d       = false
  rest_api_id          = module.cosmic_fusion_api.id
  root_resource_id     = module.cosmic_fusion_api.root_resource_id
  lambda_function_name = module.get_celebs_lambda.function_name
  lambda_invoke_arn    = module.get_celebs_lambda.invoke_arn
  request_models       = null
}

#GET friend

module "get_friend_lambda" {
  source                 = "./modules/lambda"
  lambda_zip_file        = "${var.env}GetFriend.zip"
  function_name          = "${var.env}GetFriend"
  handler                = "getFriend.handler"
  runtime                = "nodejs12.x"
  rest_api_execution_arn = module.cosmic_fusion_api.execution_arn
  lambda_bucket          = var.lambda_bucket
  env                    = var.env
  DATABASE_HOST          = trimsuffix(module.rds.endpoint, ":${var.port}")
}

module "get_friend_endpoint" {
  source               = "./modules/endpoints"
  http_method          = "GET"
  authorization        = "NONE"
  path_part            = "get-friend"
  query_string_a       = "dob"
  query_string_b       = "sex_at_birth"
  query_string_c       = "friend_dob"
  query_string_d       = "friend_sex_at_birth"
  rest_api_id          = module.cosmic_fusion_api.id
  root_resource_id     = module.cosmic_fusion_api.root_resource_id
  lambda_function_name = module.get_friend_lambda.function_name
  lambda_invoke_arn    = module.get_friend_lambda.invoke_arn
  request_models       = null
}

# POST Notification Token

module "post_token_lambda" {
  source                 = "./modules/lambda"
  lambda_zip_file        = "${var.env}PostToken.zip"
  function_name          = "${var.env}PostToken"
  handler                = "postToken.handler"
  runtime                = "nodejs12.x"
  rest_api_execution_arn = module.cosmic_fusion_api.execution_arn
  lambda_bucket          = var.lambda_bucket
  env                    = var.env
  DATABASE_HOST          = trimsuffix(module.rds.endpoint, ":${var.port}")
}

module "post_token_endpoint" {
  source               = "./modules/endpoints"
  http_method          = "POST"
  authorization        = "NONE"
  path_part            = "post-token"
  query_string_a       = false
  query_string_b       = false
  query_string_c       = false
  query_string_d       = false
  rest_api_id          = module.cosmic_fusion_api.id
  root_resource_id     = module.cosmic_fusion_api.root_resource_id
  lambda_function_name = module.post_token_lambda.function_name
  lambda_invoke_arn    = module.post_token_lambda.invoke_arn
  request_models = {
    "application/json" = "postToken"
  }
}

# Domain deployment

module "domain_deployment" {
  source          = "./modules/domain_deployment"
  rest_api_id     = module.cosmic_fusion_api.id
  stage_name      = var.env
  domain_name     = var.domain_name
  certificate_arn = var.certificate_arn
}

# RDS Database

module "rds" {
  source             = "./modules/rds"
  env                = var.env
  engine             = var.engine
  engine_version     = var.engine_version
  instance_class     = var.instance_class
  port               = var.port
  maintenance_window = var.maintenance_window
  backup_window      = var.backup_window
  subnet_ids         = var.subnet_ids
  db_family          = var.db_family
}