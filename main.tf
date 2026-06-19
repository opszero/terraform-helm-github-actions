resource "helm_release" "arc_runner_set" {
  name             = var.k8s_name
  namespace        = var.k8s_namespace
  create_namespace = true

  repository = "oci://ghcr.io/actions/actions-runner-controller-charts"
  chart      = "gha-runner-scale-set"

  values = [
    templatefile("${path.module}/arc-values.yaml", {
      github_config_url = var.config_url
      github_pat        = var.github_pat
    })
  ]
}