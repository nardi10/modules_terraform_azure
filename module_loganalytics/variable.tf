variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "log_analytics_workspace_name" {
  type = string
}
