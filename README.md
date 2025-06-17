# Deploy AWS Cognito with Terraform

This repository contains Terraform code to deploy and manage AWS Cognito resources for user authentication and authorization.

## Overview

This project sets up a complete AWS Cognito infrastructure including:

- User Pool with custom attributes and password policies
- App Client with OAuth configuration
- Custom domain for the Cognito service

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (v1.0.0+)
- AWS CLI configured with appropriate credentials
- S3 bucket for Terraform state (already configured)

## Repository Structure

- `cognito.tf` - Main Cognito resources configuration
- `config.tf` - Terraform backend configuration
- `variables.tf` - Input variables definition
- `maint.tf` - AWS provider configuration
- `terraform.tfvars` - Variable values for deployment

## Getting Started

### 1. Clone the repository

```bash
git clone <repository-url>
cd cognito-terraform
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Review the deployment plan

```bash
terraform plan
```

### 4. Apply the configuration

```bash
terraform apply
```

## Cognito Resources

### User Pool

The configuration creates a Cognito User Pool named "olcb-community-user-pool" with the following settings:

- Email as username
- Auto-verification of email addresses
- Self-registration enabled
- Password policy requiring:
  - Minimum 8 characters
  - At least one lowercase letter
  - At least one uppercase letter
  - At least one number

Custom attributes:
- Required email attribute
- Optional custom_attr (number between 1-100)

### App Client

The configuration sets up an app client named "olcb-app-client" with:

- OAuth flows: Authorization code grant and Implicit grant
- OAuth scopes: email, openid, profile
- Authentication flows: ADMIN_NO_SRP_AUTH, USER_PASSWORD_AUTH
- Callback URLs: https://example.com/callback
- Logout URLs: https://example.com/logout
- 30-day refresh token validity

### User Pool Domain

A custom domain "olcb-app-domain" is configured for the Cognito service.

## Configuration Variables

| Variable | Description | Default |
|----------|-------------|---------|
| environment | Deployment environment (dev, pre, prod, etc.) | dev |
| region | AWS region for deployment | eu-central-1 |

## State Management

Terraform state is stored in an S3 bucket with the following configuration:
- Bucket: terraform-state-olcb
- Key: cognito/terraform.tfstate
- Region: eu-central-1

## Customization

To customize the deployment:

1. Modify `terraform.tfvars` to change environment or region
2. Update `cognito.tf` to adjust Cognito settings like password policies or callback URLs
3. Run `terraform plan` to review changes
4. Apply changes with `terraform apply`

## Security Considerations

- The Cognito User Pool is configured with standard security practices
- Password policies enforce strong passwords
- OAuth flows are properly configured for web applications

## Support

For questions or issues, please contact me olcortesb@gmail.com.