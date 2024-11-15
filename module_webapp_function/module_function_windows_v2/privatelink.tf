#### Criação de private link para todos os webapps. ####

resource "azurerm_private_endpoint" "privatelink_function" {
  for_each            = var.function_names
  name                = var.private_endpoint_name[each.key]
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id = try(
    data.azurerm_subnet.subnet_privatelink[0].id,
    azurerm_subnet.subnet_privatelink[0].id
  )

  private_service_connection {
    name                           = var.private_endpoint_name[each.key]
    private_connection_resource_id = azurerm_windows_function_app.function[each.key].id
    is_manual_connection           = false
    subresource_names = [
      "sites"
    ]
  }
  tags = merge(var.tags, {
    Terraform = "Yes"
  })
}