# Se um ID de Application Insight existente for fornecido, este data source será utilizado

data "azurerm_application_insights" "app_insights" {
  count = var.application_insights_enabled && var.application_insights_id != null ? 1 : 0

  name                = split("/", var.application_insights_id)[8]
  resource_group_name = split("/", var.application_insights_id)[4]
}

# Se o ID de Application Insight for null, será criado um novo Application Insight

resource "azurerm_application_insights" "app_insights" {
  count = var.application_insights_enabled && var.application_insights_id == null ? 1 : 0

  name                = var.app_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  retention_in_days   = 30
  sampling_percentage = 50
  tags = merge(var.tags, {
    Terraform = "Yes"
  })
  workspace_id = try(
    data.azurerm_log_analytics_workspace.existing[0].id,
    azurerm_log_analytics_workspace.log[0].id
  )
}

