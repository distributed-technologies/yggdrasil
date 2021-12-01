data "azurerm_kubernetes_cluster" "main" {
  name                = "ks-${var.project_name}-${var.environment_short}-${var.environment_instance}"
  resource_group_name = var.resource_group_name
}
