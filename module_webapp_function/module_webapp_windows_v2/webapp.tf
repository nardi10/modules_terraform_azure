#### Realiza a criação de Webapps com as configurações Default estabelecida pela EDP e é possível fazer a criação em massa. ####

resource "azurerm_windows_web_app" "webapp" {
  for_each            = var.webapp_name
  name                = each.value
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id = try(
    data.azurerm_service_plan.asp[0].id,
    azurerm_service_plan.asp[0].id
  )
  https_only = true
  virtual_network_subnet_id = try(
    data.azurerm_subnet.subnet_integration[0].id,
    azurerm_subnet.subnet_integration[0].id
  )
  public_network_access_enabled = false

  #### Ignora as alterações feitas pelos desenvolvedores através do portal ou pela esteira de Devops. ####
  lifecycle {
    ignore_changes = [app_settings, connection_string, logs, site_config, sticky_settings, auth_settings_v2, identity]
  }

  app_settings = {
    "APPINSIGHTS_PROFILERFEATURE_VERSION" = "1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION" = "1.0.0"
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = try(
      data.azurerm_application_insights.app_insights[0].connection_string,
      azurerm_application_insights.app_insights[0].connection_string,
      ""
    )
    "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~3"
    "DiagnosticServices_EXTENSION_VERSION"            = "~3"
    "InstrumentationEngine_EXTENSION_VERSION"         = "disabled"
    "SnapshotDebugger_EXTENSION_VERSION"              = "disabled"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode"           = "recommended"
    "XDT_MicrosoftApplicationInsights_PreemptSdk"     = "disabled"
    "APPINSIGHTS_INSTRUMENTATIONKEY" = try(
      data.azurerm_application_insights.app_insights[0].instrumentation_key,
      azurerm_application_insights.app_insights[0].instrumentation_key,
      ""
    )
  }

  site_config {
    vnet_route_all_enabled = true
    always_on              = true

    dynamic "application_stack" {
      for_each = var.application_stack != "" ? [var.application_stack] : []

      content {
        dotnet_version = var.application_stack == "dotnet" ? var.dotnet_version : null
        python         = var.application_stack == "python" ? var.python_version : null
      }
    }
  }
  tags = merge(var.tags, {
    Terraform = "Yes"
  })

  depends_on = [azurerm_application_insights.app_insights, azurerm_log_analytics_workspace.log,
    azurerm_service_plan.asp, azurerm_subnet.subnet_integration, azurerm_subnet.subnet_privatelink,
    var.virtual_network_name
  ]
}
