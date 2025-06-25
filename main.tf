# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  #   profile = "example_profile"
}

# Configure the GitHub Provider
provider "github" {
  token = var.github_token
  # token = "token name here"
}

locals {
  default_branch = "main"
}

resource "github_repository" "example" {
  name             = "github-terraform-creation-example"
  description      = "GitHub Repo with dev/qa/main branches via Terraform example repo"
  visibility       = "public"
  auto_init        = true
  license_template = "apache-2.0"
  # archive_on_destroy = true
  # has_issues             = true
  # vulnerability_alerts   = true
  # allow_merge_commit     = false
  # delete_branch_on_merge = false
}

resource "github_branch_default" "default" {
  repository = github_repository.example.name
  branch     = local.default_branch
  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch" "dev" {
  repository = github_repository.example.name
  branch     = "dev"
  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch" "qa" {
  repository = github_repository.example.name
  branch     = "qa"
  lifecycle {
    prevent_destroy = true
  }
}
