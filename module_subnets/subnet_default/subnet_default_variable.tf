variable "subnet_address_prefixes" {
  type = list(any)
}

variable "subnet_address_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "network_security_group_id" {
  type = string
}
