resource "azurerm_key_vault" "key_vault" {
  name                          = var.key_vault_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  enabled_for_disk_encryption   = true
  tenant_id                     = "YOUR-TENANT-ID"
  soft_delete_retention_days    = 7
  purge_protection_enabled      = true
  #public_network_access_enabled = true
  network_acls {
    ip_rules = ["YOUR-IP"]
    bypass = "AzureServices"
    default_action = "Deny"
  }


  sku_name = "standard"

  tags = merge(var.tags, {
    Terraform = "Yes"
  })
}


resource "azurerm_key_vault_access_policy" "keyvault_policy" {
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = "YOUR-TENANT-ID"
  object_id    = "YOUR-OBJECT-ID"

  key_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Get",
  ]

}