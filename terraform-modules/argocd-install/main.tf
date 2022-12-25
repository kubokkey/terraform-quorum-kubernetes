resource "kubernetes_namespace" "argocd" {
  metadata { name = "argocd" }
}

data "http" "install_yaml" {
  url = "https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
}

resource "kubectl_manifest" "install" {
    yaml_body = data.http.install_yaml.body
}
