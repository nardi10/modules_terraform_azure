resource "azurerm_storage_account" "stg" {
  for_each                      = var.storage_account_names
  name                          = each.value
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  public_network_access_enabled = false

  tags = merge(var.tags, {
    Terraform = "yes"
  })
}

resource "azurerm_private_endpoint" "privatelinkstorage" {
  for_each            = var.storage_account_names
  name                = var.private_endpoint_storage_account_name[each.key]
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id = try(
    data.azurerm_subnet.subnet_privatelink[0].id,
    azurerm_subnet.subnet_privatelink[0].id
  )

  private_service_connection {
    name                           = var.private_endpoint_storage_account_name[each.key]
    private_connection_resource_id = azurerm_storage_account.stg[each.key].id
    is_manual_connection           = false
    subresource_names = [
      "Blob"
    ]
  }
  tags = merge(var.tags, {
    Terraform = "yes"
  })

}