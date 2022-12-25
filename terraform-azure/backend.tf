# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  backend "local" { path = "./terraform.tfstate" }
  #  backend "remote" {
  #    hostname     = "app.terraform.io"
  #    organization = "kubokkey"
  #    workspaces {
  #      prefix = "quorum-"
  #    }
  #  }
}
