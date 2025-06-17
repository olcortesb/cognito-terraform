terraform {
  backend "s3" {
    key          = "cognito/terraform.tfstate"
    bucket       = "terraform-state-olcb"
    region       = "eu-central-1"
    use_lockfile = true
  }
}
