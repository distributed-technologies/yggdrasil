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

module "network" {
  depends_on = [
    azurerm_resource_group.main,
    module.nsg
  ]
  source = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/virtual-network?ref=feature/aks"

  name                 = var.project_name
  environment_short    = var.environment_short
  environment_instance = var.environment_instance
  resource_group_name  = azurerm_resource_group.main.name
  location             = azurerm_resource_group.main.location

  address_spaces = ["172.18.0.0/16"]
  subnets = [
    {
      name              = "default"
      address_prefixes  = ["172.18.0.0/24"]
      security_group_id = module.nsg.id
    },
    {
      name              = "cluster_network"
      address_prefixes  = ["172.18.128.0/17"]
      security_group_id = module.nsg.id
    },
  ]
}
