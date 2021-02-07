resource "aws_lambda_function" "myLambda" {
  function_name = "firstFunction"

  s3_bucket = "lambda-functions"
  s3_key    = var.lambda_zip_file

  handler = var.handler
  runtime = var.runtime

  role = aws_iam_role.lambda_role.arn
}

# IAM role which dictates what other AWS services the Lambda function
# may access.
resource "aws_iam_role" "lambda_role" {
  name = "role_lambda"

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