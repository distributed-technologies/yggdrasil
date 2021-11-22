data "azurerm_public_ip" "ingress_ip" {
  name                = "pip-${var.project_name}-${var.environment_short}-${var.environment_instance}"
  resource_group_name =  var.resource_group_name
}
