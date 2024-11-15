
resource "azurerm_subnet" "snetname" {
  name                 = var.subnet_address_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.subnet_address_prefixes
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.snetname.id
  network_security_group_id = var.network_security_group_id
}
