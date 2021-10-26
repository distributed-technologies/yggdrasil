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

terraform {
  required_version = ">= 1.0.8"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.78.0" # locked to 2.78.0 because of following issue. https://github.com/hashicorp/terraform-provider-azurerm/issues/11396
    }
//    kubernetes = {
//      source  = "hashicorp/kubernetes"
//      version = ">= 2.5.0"
//    }
//    helm = {
//      source  = "hashicorp/helm"
//      version = ">= 2.3.0"
//    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  # client_id       = var.azure_client_id
  # client_secret   = var.azure_client_secret
  features {}
}


//provider "kubernetes" {
//  host                   = module.kubernetes.kube_admin_config.0.host
//  client_certificate     = base64decode(module.kubernetes.kube_admin_config.0.client_certificate)
//  client_key             = base64decode(module.kubernetes.kube_admin_config.0.client_key)
//  cluster_ca_certificate = base64decode(module.kubernetes.kube_admin_config.0.cluster_ca_certificate)
//}

//provider "helm" {
//  kubernetes {
//    host                   = module.kubernetes.kube_admin_config.0.host
//    client_certificate     = base64decode(module.kubernetes.kube_admin_config.0.client_certificate)
//    client_key             = base64decode(module.kubernetes.kube_admin_config.0.client_key)
//    cluster_ca_certificate = base64decode(module.kubernetes.kube_admin_config.0.cluster_ca_certificate)
//  }
//}
