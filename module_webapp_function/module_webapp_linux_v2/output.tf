#### Application Insights ####

output "application_insights_instrumentation_key" {
  description = "Instrumentation key of the Application Insights"
  value = try(
    length(data.azurerm_application_insights.app_insights) > 0 ? data.azurerm_application_insights.app_insights[0].instrumentation_key : null,
    length(azurerm_application_insights.app_insights) > 0 ? azurerm_application_insights.app_insights[0].instrumentation_key : null
  )
  sensitive = true
}

output "application_insights_connection_string" {
  description = "Connection string of the Application Insights"
  value = try(
    length(data.azurerm_application_insights.app_insights) > 0 ? data.azurerm_application_insights.app_insights[0].connection_string : null,
    length(azurerm_application_insights.app_insights) > 0 ? azurerm_application_insights.app_insights[0].connection_string : null
  )
}

#### LOG ANALYTICS ####

output "log_analytics_workspace_id" {
  value = try(
    data.azurerm_log_analytics_workspace.existing[0].id,
    azurerm_log_analytics_workspace.log[0].id
  )
}

#### SERVICE PLAN ####

output "service_plan_id" {
  description = "ID of the Service Plan"
  value = try(
    data.azurerm_service_plan.asp[0].id,
    azurerm_service_plan.asp[0].id
  )
}

#### SUBNET INTEGRATION ####

# Output do ID da subnet de integração
output "subnet_integration_id" {
  description = "ID da Subnet de Integração"
  value = coalesce(
    try(azurerm_subnet.subnet_integration[0].id, null),
    try(data.azurerm_subnet.subnet_integration[0].id, null)
  )
}

#### SUBNET PRIVATE LINK ####

# Output do ID da subnet de PRIVATE LINK
output "subnet_privatelink_id" {
  description = "ID da Subnet de Integração"
  value = coalesce(
    try(azurerm_subnet.subnet_privatelink[0].id, null),
    try(data.azurerm_subnet.subnet_privatelink[0].id, null)
  )
}