# 1. User Pool
resource "aws_cognito_user_pool" "this" {
  name                     = "olcb-community-user-pool"
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_uppercase = true
    require_numbers   = true
    require_symbols   = false
  }

  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = true
    mutable             = true
  }

  schema {
    name                = "custom_attr"
    attribute_data_type = "Number"
    required            = false
    mutable             = true
    number_attribute_constraints {
      min_value = 1
      max_value = 100
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

# 2. App Client
resource "aws_cognito_user_pool_client" "this" {
  name                                 = "olcb-app-client"
  user_pool_id                         = aws_cognito_user_pool.this.id
  generate_secret                      = false
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  explicit_auth_flows                  = ["ADMIN_NO_SRP_AUTH", "USER_PASSWORD_AUTH"]
  callback_urls                        = ["https://example.com/callback"]
  logout_urls                          = ["https://example.com/logout"]

  supported_identity_providers = ["COGNITO"]
  refresh_token_validity       = 30
}

# 3. User Pool Domain
resource "aws_cognito_user_pool_domain" "this" {
  domain       = "olcb-app-domain"
  user_pool_id = aws_cognito_user_pool.this.id
}