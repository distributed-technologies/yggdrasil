resource "helm_release" "nidhogg" {
  name              = "nidhogg"
  chart             = "../../nidhogg"
  dependency_update = true
  timeout           = 600

  values = [
    file("${path.cwd}/../../env/${var.environment_folder}/nidhogg.yaml")
  ]

  set {
    name  = "nidhogg.yggdrasil.ingress.loadBalancerIP"
    value = data.azurerm_public_ip.ingress_ip.ip_address
  }

  set {
    name  = "nidhogg.yggdrasil.ingress.loadbalancerResourceGroup"
    value = var.resource_group_name
  }

  dynamic "set" {
    for_each = data.azurerm_public_ip.ingress_ip.fqdn != "" ? [1] : []
    content {
      name  = "nidhogg.yggdrasil.ingressDomain"
      value = data.azurerm_public_ip.ingress_ip.fqdn
    }
  }

  set {
    name  = "nidhogg.yggdrasil.targetRevision"
    value = var.target_revision
  }

  dynamic "set" {
    for_each = var.sealed_secret_crt != null ? [1] : []
    content {
      name  = "nidhogg.yggdrasil.sealedSecret.devSecret.crt"
      value = var.sealed_secret_crt
    }
  }

  dynamic "set" {
    for_each = var.sealed_secret_key != null ? [1] : []
    content {
      name  = "nidhogg.yggdrasil.sealedSecret.devSecret.key"
      value = var.sealed_secret_key
    }
  }
}
