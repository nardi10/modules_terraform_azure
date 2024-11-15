resource "azurerm_private_endpoint" "privatelinkstorage" {
  name                = var.private_endpoint_storage_account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_address_private_storage_account_id

  private_service_connection {
    name                           = var.private_endpoint_storage_account_name
    private_connection_resource_id = azurerm_storage_account.stg.id
    is_manual_connection           = false
    subresource_names = [
      "Blob"

    ]
  }
  tags = var.tags
}

resource "azurerm_private_endpoint" "privatelink_function" {
  name                = var.private_endpoint_function_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_address_private_function_id

  private_service_connection {
    name                           = var.private_endpoint_function_name
    private_connection_resource_id = azurerm_linux_function_app.func.id
    is_manual_connection           = false
    subresource_names = [
      "sites"

    ]
  }

  tags = merge(var.tags, {
    Terraform = "yes"
  })
}