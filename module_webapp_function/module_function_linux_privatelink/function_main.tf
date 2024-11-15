resource "azurerm_storage_account" "stg" {
  name                            = var.storage_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  public_network_access_enabled   = false
  allow_nested_items_to_be_public = true

  tags = merge(var.tags, {
    Terraform = "Yes"
  })
}

resource "azurerm_linux_function_app" "func" {
  name                = var.function_name
  resource_group_name = var.resource_group_name
  location            = var.location

  storage_account_name          = azurerm_storage_account.stg.name
  storage_account_access_key    = azurerm_storage_account.stg.primary_access_key
  service_plan_id               = var.service_plan_id
  https_only                    = true
  public_network_access_enabled = false
  virtual_network_subnet_id     = var.subnet_address_integration_id
  builtin_logging_enabled       = false

  lifecycle {
    ignore_changes = [app_settings]
  }

  sticky_settings {
    app_setting_names = [

      "APPINSIGHTS_INSTRUMENTATIONKEY",
      "APPLICATIONINSIGHTS_CONNECTION_STRING",
      "APPINSIGHTS_PROFILERFEATURE_VERSION",
      "APPINSIGHTS_SNAPSHOTFEATURE_VERSION",
      "ApplicationInsightsAgent_EXTENSION_VERSION",
      "XDT_MicrosoftApplicationInsights_BaseExtensions",
      "DiagnosticServices_EXTENSION_VERSION",
      "InstrumentationEngine_EXTENSION_VERSION",
      "SnapshotDebugger_EXTENSION_VERSION",
      "XDT_MicrosoftApplicationInsights_Mode",
      "XDT_MicrosoftApplicationInsights_PreemptSdk",
      "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT",
      "XDT_MicrosoftApplicationInsightsJava",
      "XDT_MicrosoftApplicationInsights_NodeJS"
    ]
  }

  site_config {

    vnet_route_all_enabled                 = true
    always_on                              = true
    application_insights_connection_string = var.app_insights_connection_string
    application_insights_key               = var.application_insights_key

    application_stack {
      node_version = var.application_stack
    }

  }

  tags = merge(var.tags, {
    Terraform = "yes"
  })
}

resource "azurerm_app_service_virtual_network_swift_connection" "vintegration" {
  count          = var.enable_vnet_integration == false ? 1 : 0
  app_service_id = azurerm_linux_function_app.func.id
  subnet_id      = var.subnet_address_integration_id
  depends_on     = [azurerm_linux_function_app.func]

}