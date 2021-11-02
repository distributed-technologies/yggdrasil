
variable "resource_group_name" {
  description = "The name of the Azure resource group in which to place the resources."
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type = string
}

variable "location" {
  description = "Azure region, default is West Europe"
  type        = string
  default     = "West Europe"
}

variable environment_short {
  type          = string
  description   = "Enviroment that the infrastructure code is deployed into."
}

variable environment_instance {
  type          = string
  description   = "Enviroment instance that the infrastructure code is deployed into."
}

variable project_name {
  type          = string
  description   = "Name of the project this infrastructure is a part of."
}

variable "arm_client_object_id" {
  description = "Object ID of the service principal"
  type        = string
}

# variable "azure_spn_id" {
#   description = "ID of the service principal, if not set then local AZ user is used."
#   type        = string
#   default     = null
# }

# variable "azure_spn_secret" {
#   description = "Secret for the Azure service principal used, if not set then local AZ user is used."
#   type        = string
#   default     = null
#   sensitive   = true
# }
