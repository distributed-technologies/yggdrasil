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

data "azuread_client_config" "current" {}

resource "kubernetes_secret" "argo_oidc_secret" {
  count = var.sso != null ? 1 : 0

  metadata {
    name = "argocd-auth-secret"
    labels = {
      "app.kubernetes.io/part-of" = "argocd"
    }
  }

  data = {
    "oidc.azure.issuer"       = "https://login.microsoftonline.com/${data.azuread_client_config.current.tenant_id}/v2.0"
    "oidc.azure.clientId"     = var.sso.client_id
    "oidc.azure.clientSecret" = var.sso.client_secret
  }

  type = "Opaque"
}
