resource "azurerm_windows_virtual_machine" "vm" {

  for_each = var.virtual_machine_name

  name                = each.value
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  license_type        = "Windows_Server"

  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  boot_diagnostics {

  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  source_image_id = var.vm_image_id

  dynamic "source_image_reference" {
    for_each = var.vm_image_id == null ? ["fake"] : []
    content {
      offer     = lookup(var.vm_image, "offer", null)
      publisher = lookup(var.vm_image, "publisher", null)
      sku       = lookup(var.vm_image, "sku", null)
      version   = lookup(var.vm_image, "version", null)
    }
  }

  tags = merge(var.tags, {
    Terraform = "Yes"
  })

  depends_on = [azurerm_network_interface.nic]

}

resource "azurerm_network_interface" "nic" {
  for_each            = var.virtual_machine_name
  name                = "nic-${each.value}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_address_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = merge(var.tags, {
    Terraform = "Yes"
  })
}

resource "azurerm_backup_protected_vm" "enable_backup" {
  for_each            = var.virtual_machine_name
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_services_vault_name
  source_vm_id        = azurerm_windows_virtual_machine.vm[each.key].id
  backup_policy_id    = var.backup_policy_id

  depends_on = [var.resource_group_name]
  lifecycle {
    ignore_changes = [source_vm_id]
  }

}

resource "azurerm_virtual_machine_extension" "AzureMonitorWindowsAgent" {
  for_each                   = var.virtual_machine_name
  name                       = "AzureMonitorWindowsAgent"
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorWindowsAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm[each.key].id
  tags = merge(var.tags, {
    Terraform = "Yes"
  })

  settings = <<SETTINGS
            {
              "workspaceId" : "${var.log_analytics_workspace_id}"
            }
          SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
            {
              "workspaceKey" : "${var.log_analytics_workspace_key}"
            }
          PROTECTED_SETTINGS
}

resource "azurerm_virtual_machine_extension" "MicrosoftMonitoringAgent" {
  for_each                   = var.virtual_machine_name
  name                       = "MicrosoftMonitoringAgent"
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm[each.key].id
  tags = merge(var.tags, {
    Terraform = "Yes"
  })

  settings = <<SETTINGS
            {
              "workspaceId" : "${var.log_analytics_workspace_id}"
            }
          SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
            {
              "workspaceKey" : "${var.log_analytics_workspace_key}"
            }
          PROTECTED_SETTINGS
}
