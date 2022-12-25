data "kubernetes_secret" "argocd_admin_secret" {
  metadata {
    namespace = "argocd"
    name      = "argocd-initial-admin-secret"
  }
}

output "argocd_admin_secret" {
  value = data.kubernetes_secret.argocd_admin_secret.data.password
}
