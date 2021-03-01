resource "aws_lambda_function" "lambda" {
  function_name = var.function_name

  s3_bucket = var.lambda_bucket
  s3_key    = var.lambda_zip_file

  handler = var.handler
  runtime = var.runtime

  role = aws_iam_role.lambda_role.arn

  # environment {
  #   variables = {
  #     DATABASE_USERNAME = var.DATABASE_USERNAME
  #     DATABASE_PASSWORD = var.DATABASE_PASSWORD
  #     DATABASE_PORT     = var.DATABASE_PORT
  #     DATABASE_HOST     = var.DATABASE_HOST
  #     DATABASE_NAME     = var.DATABASE_NAME
  #   }
  # }
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${var.rest_api_execution_arn}/*/*"
}

# IAM role which dictates what other AWS services the Lambda function
# may access.
resource "aws_iam_role" "lambda_role" {
  name = "${var.function_name}_role_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}