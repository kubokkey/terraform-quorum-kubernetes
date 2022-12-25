# Infra Setup
module "quorum_aks_setup" {
  source                  = "../terraform-modules/quorum-aks-setup"
  arm_template_parameters = var.arm_template_parameters
}

module "argocd_install" {
  source         = "../terraform-modules/argocd-install"
  kubeconfig_raw = module.quorum_aks_setup.kubeconfig_raw
}

# ArgoCD register repogitory
resource "tls_private_key" "argocd" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "github_repository" "x" {
  for_each  = toset(var.argocd_repos)
  full_name = each.value
}

resource "github_repository_deploy_key" "argocd_deploy_key" {
  for_each   = data.github_repository.x
  title      = "ArgoCD"
  repository = each.value.name
  key        = tls_private_key.argocd.public_key_openssh
  read_only  = "true"
}

resource "argocd_repository" "x" {
  depends_on = [module.argocd_install]

  for_each        = data.github_repository.x
  name            = each.value.name
  repo            = "git@github.com:${each.value.full_name}"
  username        = "git"
  ssh_private_key = tls_private_key.argocd.private_key_openssh
}

# ArgoCD Application define
resource "argocd_application" "goquorum-node" {
  depends_on = [argocd_repository.x]

  metadata {
    name      = "goquorum-node"
    namespace = "argocd"
  }

  spec {
    source {
      repo_url        = "git@github.com:kubokkey/quorum-chart.git"
      path            = "goquorum-node"
      target_revision = "1339_add-chart"
      helm {
        value_files = ["values.yaml"]
      }
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "default"
    }
  }
}

resource "argocd_application" "goquorum-genesis" {
  depends_on = [argocd_repository.x]

  metadata {
    name      = "goquorum-genesis"
    namespace = "argocd"
  }

  spec {
    source {
      repo_url        = "git@github.com:kubokkey/quorum-chart.git"
      path            = "goquorum-genesis"
      target_revision = "1339_add-chart"
      helm {
        value_files = ["values.yaml"]
      }
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "default"
    }
  }
}