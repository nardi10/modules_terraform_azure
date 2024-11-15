resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.virtual_network_range
  dns_servers         = var.dns_servers

  tags = merge(var.tags, {
    Terraform = "Yes"
  })
}

