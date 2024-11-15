resource "azurerm_private_endpoint" "privatelinksqlserver" {
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_address_id

  private_service_connection {
    name                           = var.private_endpoint_name
    private_connection_resource_id = azurerm_mssql_server.sqlserver.id
    is_manual_connection           = false
    subresource_names = [
      "sqlserver"

    ]
  }

  tags = merge(var.tags, {
    Terraform = "Yes"
  })
}