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

module "nsg" {
  depends_on = [
    azurerm_resource_group.main,
  ]
  source = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/network-security-group?ref=feature/aks"

  name                 = var.project_name
  environment_short    = var.environment_short
  environment_instance = var.environment_instance
  resource_group_name  = azurerm_resource_group.main.name
  location             = azurerm_resource_group.main.location
}


resource "azurerm_network_security_rule" "http" {
  depends_on = [
    azurerm_resource_group.main,
    module.nsg,
    module.public_ip
  ]

  name                        = "http"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "20.76.235.110" # Should be possible to use tag on ip resource "ingress-traefik"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = module.nsg.name
}

resource "azurerm_network_security_rule" "https" {
  depends_on = [
    azurerm_resource_group.main,
    module.nsg,
    module.public_ip
  ]

  name                        = "https"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "20.76.235.110" # Should be possible to use tag on ip resource "ingress-traefik"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = module.nsg.name
}
