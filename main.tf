resource "helm_release" "arc" {
  name             = "arc"
  namespace        = var.k8s_namespace
  create_namespace = true

  repository = "oci://ghcr.io/actions/actions-runner-controller-charts"
  chart      = "gha-runner-scale-set-controller"
}

resource "helm_release" "arc_runner_set" {
  name             = "arc-runner-set"
  namespace        = var.k8s_namespace
  create_namespace = true

  repository = "oci://ghcr.io/actions/actions-runner-controller-charts"
  chart      = "gha-runner-scale-set"

  # https://github.com/actions/actions-runner-controller/blob/master/charts/gha-runner-scale-set/values.yaml
  values = [
    templatefile("${path.module}/arc-runner-set-values.yaml", {
      github_config_url = var.config_url
      github_pat        = var.github_pat
      k8s_namespace     = var.k8s_namespace
    })
  ]

  depends_on = [helm_release.arc]
}
