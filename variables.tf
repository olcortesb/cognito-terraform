variable "environment" {
  description = "Platform environment (prod|dev|stg|qa|mgt|...)"
  type        = string

  validation {
    condition = contains([
      "dev", "pre", "pro", "prod", "staging", "stg", "qa", "mgt", "demo"
    ], var.environment)
    error_message = "The 'environment' value must be one of the following: dev, pre, pro, prod, staging, stg, qa, mgt."
  }
}

variable "region" {
  description = "AWS Region"
  type        = string
}

