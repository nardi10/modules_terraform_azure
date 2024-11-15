resource "azurerm_storage_account" "storage_account" {
  name                          = var.storage_account_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  public_network_access_enabled = false
  allow_nested_items_to_be_public = false

  tags = merge(var.tags, {
    Terraform = "Yes"
  })
}