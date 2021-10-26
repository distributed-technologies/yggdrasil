
variable "resource_group_name" {
  description = "The name of the Azure resource group in which to place the resources."
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type = string
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
