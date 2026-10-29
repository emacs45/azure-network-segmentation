variable "subscription_id" {
  description = "Azure subscription ID used for deployment"
  type        = string
}

variable "resource_group_name" {
  description = "Name of an existing Azure resource group"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key used for VM authentication"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_B1s"
}