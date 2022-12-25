terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }
  }
}

resource "local_file" "kubeconfig" {
  filename = "./.kubeconfig"
  content  = var.kubeconfig_raw
}

provider "kubernetes" {
  config_path = local_file.kubeconfig.filename
}
