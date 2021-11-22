resource "helm_release" "nidhogg" {
  name              = "nidhogg"
  chart             = "../../nidhogg"
  dependency_update = true
  timeout = 600

  values = [
    file("${path.cwd}/../../env/${var.environment_short}/nidhogg.yaml")
  ]

  set {
    name  = "nidhogg.yggdrasil.ingress.loadBalancerIP"
    value = data.azurerm_public_ip.ingress_ip.ip_address
  }

  set {
    name  = "nidhogg.yggdrasil.ingress.loadbalancerResourceGroup"
    value =  var.resource_group_name
  }
}
