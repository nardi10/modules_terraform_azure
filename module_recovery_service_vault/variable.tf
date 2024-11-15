variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "recovery_services_vault_name" {
  type = string
}

variable "backup_policy_name" {
  type = string
}

