resource "aws_api_gateway_rest_api" "cosmic_fusion" {
  name = var.api_name
}

resource "aws_api_gateway_model" "input_model" {
  rest_api_id  = aws_api_gateway_rest_api.cosmic_fusion.id
  name         = "postToken"
  description  = "a JSON schema for subscribing a user to push notifications"
  content_type = "application/json"

  schema = <<EOF
{
    "type":"object",
    "properties":{
        "userId":{"type":"string"},
        "notificationId":{"type":"string"},
        "notificationType":{"type":"string"}
    },
    "title":"Post Token"
}
EOF
}