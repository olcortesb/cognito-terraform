data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

provider "aws" {
  region = var.region
  default_tags {
    tags = { builtWith = "terraform" }
  }
}
