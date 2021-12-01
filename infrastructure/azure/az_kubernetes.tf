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

module "kubernetes" {
  depends_on = [
    azurerm_resource_group.main,
    module.network,
    module.public_ip,
  ]
  source = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/kubernetes-service?ref=feature/aks"

  name                 = var.project_name
  environment_short    = var.environment_short
  environment_instance = var.environment_instance
  resource_group_name  = azurerm_resource_group.main.name
  location             = azurerm_resource_group.main.location
  sku_tier             = "Free"
  vnet_subnet_id       = module.network.subnets.cluster_network.id
  kubernetes_version   = "1.20.9"
  outbound_ip_address_ids = [
    module.public_ip.id
  ]

  default_nodes = {
    vm_size    = "standard_ds2_v2"
    node_count = 1
    min_count  = 1
    max_count  = 3
  }

  identity_type = "UserAssigned"
  identity_id   = azurerm_user_assigned_identity.aks_mid.id
}
