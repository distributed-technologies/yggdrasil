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

variable "resource_group_name" {
  description = "The name of the Azure resource group in which to place the resources."
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "environment_short" {
  type        = string
  description = "Enviroment that the infrastructure code is deployed into."
}

variable "environment_instance" {
  type        = string
  description = "Enviroment instance that the infrastructure code is deployed into."
}

variable "environment_folder" {
  type        = string
  description = "The folder containing the environment specific settings."
}

variable "project_name" {
  type        = string
  description = "Name of the project this infrastructure is a part of."
}

variable "target_revision" {
  type        = string
  description = "Name of the branch"
}

variable "sealed_secret_master" {
  type = object({
    crt  = string,
    key  = string
  })
  description = "Sealed-secret master key for development only"
  sensitive   = true
  default     = null
}

variable "sso" {
  type = object({
    client_id     = string,
    client_secret = string
  })
  sensitive = true
  default   = null
}
