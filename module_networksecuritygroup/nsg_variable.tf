variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "network_security_group_name" {
  type = string
}

variable "tags" {
  type = map(any)
}
