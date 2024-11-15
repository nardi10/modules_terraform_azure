#### Criação de private link para todos os webapps. ####

resource "azurerm_private_endpoint" "privatelink_webapp" {
  for_each            = var.webapp_name
  name                = var.private_endpoint_name[each.key]
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id = try(
    data.azurerm_subnet.subnet_privatelink[0].id,
    azurerm_subnet.subnet_privatelink[0].id
  )

  private_service_connection {
    name                           = var.private_endpoint_name[each.key]
    private_connection_resource_id = azurerm_linux_web_app.webapp[each.key].id
    is_manual_connection           = false
    subresource_names = [
      "sites"
    ]
  }
  tags = merge(var.tags, {
    Terraform = "Yes"
  })
}