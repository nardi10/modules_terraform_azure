resource "azurerm_recovery_services_vault" "rsv" {
  name                = var.recovery_services_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  soft_delete_enabled = true
  storage_mode_type   = "LocallyRedundant"


  tags = merge(var.tags, {
    Terraform = "Yes"
  })

  depends_on = [var.resource_group_name]

}

resource "azurerm_backup_policy_vm" "policy_vm" {
  name                = var.backup_policy_name
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_services_vault_name

  timezone = "E. South America Standard Time"

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 21
  }

  depends_on = [azurerm_recovery_services_vault.rsv]

}

resource "azurerm_monitor_diagnostic_setting" "log-anlaytcs" {
  name                       = "YOUR-LOG-ANALYTICS"
  target_resource_id         = azurerm_recovery_services_vault.rsv.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log-rsv-prod.id

  enabled_log {
    category_group = "allLogs"

    retention_policy {
      days    = 0
      enabled = false
    }
  }

  metric {
    category = "Health"
    enabled  = true

    retention_policy {
      days    = 0
      enabled = false
    }
  }

}