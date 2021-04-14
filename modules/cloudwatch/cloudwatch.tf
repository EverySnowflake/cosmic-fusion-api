resource "aws_cloudwatch_event_rule" "rule" {
  name                = var.name
  description         = var.description
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "check_foo_every_one_minute" {
  rule      = aws_cloudwatch_event_rule.rule.name
  target_id = "lambda"
  arn       = var.lambda_function_arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.rule.arn
}