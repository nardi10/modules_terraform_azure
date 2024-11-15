variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "subnet_address_id" {
  type = string
}

variable "virtual_machine_name" {
  type = map(string)
}

variable "admin_username" {
  type    = string
  default = "edp_admin"
}

variable "admin_password" {
  type    = string
  default = "Bandeirante#2018!"
}

variable "storage_account_type" {
  type = string
}

variable "size" {
  type = string
}

variable "vm_image_id" {
  description = "The ID of the Image which this Virtual Machine should be created from. This variable supersedes the `vm_image` variable if not null."
  type        = string
  default     = null
}

variable "vm_image" {
  description = "Virtual Machine source image information. See https://www.terraform.io/docs/providers/azurerm/r/windows_virtual_machine.html#source_image_reference."
  type        = map(string)
}

variable "recovery_services_vault_name" {
  type = string
}

variable "backup_policy_id" {
  type = string
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "log_analytics_workspace_key" {
  type = string
}

