
variable "resource_group_name" {
  description = "The name of the Azure resource group in which to place the resources."
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region, default is West Europe"
  type        = string
  default     = "West Europe"
}

variable "environment_short" {
  type        = string
  description = "Enviroment that the infrastructure code is deployed into."
}

variable "environment_instance" {
  type        = string
  description = "Enviroment instance that the infrastructure code is deployed into."
}

variable "project_name" {
  type        = string
  description = "Name of the project this infrastructure is a part of."
}

variable "generate_fqdn" {
  description = "generates a fqdn on azure"
  type        = bool
  default     = false
}

variable "assign_network_contributor" {
  description = "Enables assignment of network contributor role to AKS identity"
  type        = bool
  default     = false
}
