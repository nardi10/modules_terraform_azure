# Se um ID de Log Analytics existente for fornecido, este data source será utilizado

data "azurerm_log_analytics_workspace" "existing" {
  count               = var.log_analytics_workspace_id != null ? 1 : 0
  name                = var.log_analytics_workspace_name
  resource_group_name = var.resource_group_name
}

# Se o ID de Log Analytics for null, será criado um novo Log Analytics

resource "azurerm_log_analytics_workspace" "log" {
  count = var.log_analytics_workspace_id == null ? 1 : 0

  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  daily_quota_gb      = 1

  tags = merge(var.tags, {
    Terraform = "Yes"
  })
}

