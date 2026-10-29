variable "subscription_id" {
  description = "Azure subscription ID used for deployment"
  type        = string
}

variable "location" {
  description = "Azure region for the deployment"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the existing resource group"
  type        = string
  default     = "AZ-104-M4B-9JPE0E45DT"
}