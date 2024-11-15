#output "log_analytics_workspace_id" {
#  value = azurerm_log_analytics_workspace.log.workspace_id
#}

output "log_analytics_workspace_key" {
  value = azurerm_log_analytics_workspace.log.primary_shared_key
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.log.id
}