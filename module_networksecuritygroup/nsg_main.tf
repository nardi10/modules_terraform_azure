resource "azurerm_network_security_group" "nsg" {
  name                = var.network_security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = merge(var.tags, {
    Terraform = "Yes"
  })

  depends_on = [ var.resource_group_name ]

}