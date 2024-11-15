variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "database_name" {
  type = string
}

variable "location" {
  type = string
}

variable "database_collation" {
  type    = string
  default = "SQL_Latin1_General_CP1_CI_AS"
}

variable "database_sku_name" {
  type = string
}

variable "sqlserver_id" {
  type = string
}

variable "elastic_pool_id" {
  type = string
}