# Copyright 2020 Energinet DataHub A/S
#
# Licensed under the Apache License, Version 2.0 (the "License2");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


data "azurerm_client_config" "current" {
}

module "key_vault" {
  depends_on = [
    azurerm_resource_group.main,
    module.network,
    module.public_ip,
  ]
  source               = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault?ref=4.1.0"

  name                 = var.project_name
  environment_short    = var.environment_short
  environment_instance = var.environment_instance
  resource_group_name  = azurerm_resource_group.main.name
  location             = azurerm_resource_group.main.location
  sku_name             = "standard"

  access_policies = [
    {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = azurerm_user_assigned_identity.aks_mid.id
      secret_permissions      = ["get", "list"]
      certificate_permissions = ["get", "list"]
      key_permissions         = ["get", "list"]
      storage_permissions     = ["get", "list"]
    }
  ]
}
