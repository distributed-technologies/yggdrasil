resource "helm_release" "nidhogg" {
  name              = "nidhogg"
  chart             = "../../nidhogg"
  dependency_update = true
  timeout = 600

  values = [
    file("env/${var.environment_short}/nidhogg.yaml")
  ]

  set {
    name  = "nidhogg.yggdrasil.loadBalancerIP"
    value = data.azurerm_public_ip.ingress_ip.ip_address
  }

  set {
    name  = "nidhogg.yggdrasil.loadbalancerResourceGroup"
    value =  var.resource_group_name
  }
}
