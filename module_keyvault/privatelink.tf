resource "azurerm_private_endpoint" "privatelinkkeyvault" {
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_address_id

  private_service_connection {
    name                           = var.private_endpoint_name
    private_connection_resource_id = azurerm_key_vault.key_vault.id
    is_manual_connection           = false
    subresource_names = [
      "Vault"
    ]
  }

  tags = merge(var.tags, {
    Terraform = "Yes"
  })
}