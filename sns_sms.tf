# IAM Role for Cognito to send SMS via SNS
resource "aws_iam_role" "cognito_sms_role" {
  name = "cognito-sms-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "cognito-idp.amazonaws.com"
        },
        Action = "sts:AssumeRole",
        Condition = {
          StringEquals = {
            "sts:ExternalId" = "cognito-external-id"
          }
        }
      }
    ]
  })
}

# IAM Policy for Cognito SMS Role
resource "aws_iam_role_policy" "cognito_sms_policy" {
  name = "cognito-sms-policy"
  role = aws_iam_role.cognito_sms_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "sns:Publish"
        ],
        Resource = "*"
      }
    ]
  })
}