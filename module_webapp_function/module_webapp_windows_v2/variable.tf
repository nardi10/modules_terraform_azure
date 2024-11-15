#### Varíaveis Default para criação de recursos ####

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "webapp_name" {
  type = map(string)
}

variable "application_stack" {
  type = string
}

variable "dotnet_version" {
  type    = string
  default = null
}

variable "python_version" {
  type    = string
  default = null
}

variable "app_insights_name" {
  type = string
}

variable "private_endpoint_name" {
  type = map(string)
}

variable "service_plan_name" {
  type = string
}

variable "service_plan_os_type" {
  type = string
}

variable "service_plan_sku_name" {
  type = string
}

variable "subnet_address_integration_prefixes" {
  type = list(any)
}

variable "subnet_address_integration_name" {
  type = string
}

variable "network_security_group_id" {
  type = string
}

variable "subnet_privatelink_name" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "subnet_privatelink_prefixes" {
  type = list(any)
}

variable "log_analytics_workspace_name" {
  type = string
}


#### Varíaveis para reaproveitarmos os recursos existentes em caso de necessidade ####

variable "log_analytics_workspace_id" {
  type    = string
  default = null
}

variable "subnet_integration_id" {
  type    = string
  default = null
}

variable "service_plan_id" {
  type    = string
  default = null
}

variable "application_insights_id" {
  description = "ID of the existing Application Insights to use instead of deploying a new one."
  type        = string
  default     = null
}

variable "subnet_address_private_id" {
  type    = string
  default = null
}

variable "application_insights_enabled" {
  description = "Use Application Insights for this App Service"
  type        = bool
  default     = true
}