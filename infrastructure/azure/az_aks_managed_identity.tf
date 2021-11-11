resource "azurerm_user_assigned_identity" "aks_mid" {
  depends_on = [
    azurerm_resource_group.main,
  ]

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name                = var.azure_aks_spn_name
}
