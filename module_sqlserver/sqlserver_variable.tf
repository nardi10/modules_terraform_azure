
variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "sqlserver_name" {
  type = string
}

variable "location" {
  type = string
}

variable "administrator_login" {
  type    = string
  default = "YOUR-USER"
}

variable "administrator_login_password" {
  type    = string
  default = "YOUR-PASSWORD"
}

variable "license_type" {
  type    = string
  default = "LicenseIncluded"
}

variable "private_endpoint_name" {
  type = string
}

variable "subnet_address_id" {
  type = string
}