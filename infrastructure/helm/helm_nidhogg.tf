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
    for_each = var.sealed_secret_master != null ? [1] : []
    content {
      name  = "nidhogg.yggdrasil.sealedSecret.devSecret.crt"
      value = var.sealed_secret_master.crt
    }
  }

  dynamic "set" {
    for_each = var.sealed_secret_master != null ? [1] : []
    content {
      name  = "nidhogg.yggdrasil.sealedSecret.devSecret.key"
      value = var.sealed_secret_master.key
    }
  }
}
