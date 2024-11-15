
variable "function_name" {
  type = string
}

variable "storage_name" {
  type = string
}

variable "application_stack" {
  type = string
}

variable "app_insights_connection_string" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "service_plan_id" {
  type = string
}

variable "subnet_address_integration_id" {
  type = string
}

variable "app_insights_name" {
  type = string
}

#variable "app_insights_instrumentation_key" {
#  type = string
#}

variable "private_endpoint_storage_account_name" {
  type = string
}

variable "private_endpoint_function_name" {
  type = string
}

variable "subnet_address_private_function_id" {
  type = string
}


variable "subnet_address_private_storage_account_id" {
  type = string
}

variable "enable_vnet_integration" {
  description = "Manages an App Service Virtual Network Association"
  default     = false
}

variable "application_insights_key" {
  type = string
}

variable "app_settings" {
  type = map(any)
}
