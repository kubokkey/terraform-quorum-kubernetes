terraform {
  required_version = ">= 1.2.0"
  required_providers {
    argocd = {
      source  = "oboukili/argocd"
      version = "4.2.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.12.0"
    }    
  }
}

provider "github" {}

provider "argocd" {
  server_addr = "localhost:8080"
  username    = "admin"
  password    = module.argocd_install.argocd_admin_secret
  insecure    = true
  grpc_web    = true
}
