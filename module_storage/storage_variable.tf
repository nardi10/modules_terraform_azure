variable "storage_account_name" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "private_endpoint_name" {
  type = string
}

variable "subnet_address_id" {
  type = string
}
