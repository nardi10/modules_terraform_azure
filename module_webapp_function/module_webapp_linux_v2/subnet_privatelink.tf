# Se um ID de subnet existente for fornecido, este data source será utilizado
data "azurerm_subnet" "subnet_privatelink" {
  count                = var.subnet_address_private_id != null ? 1 : 0
  name                 = split("/", var.subnet_address_private_id)[10]
  resource_group_name  = split("/", var.subnet_address_private_id)[4]
  virtual_network_name = split("/", var.subnet_address_private_id)[8]
}

# Se o ID de subnet for null, será criada uma nova subnet
resource "azurerm_subnet" "subnet_privatelink" {
  count = var.subnet_address_private_id == null ? 1 : 0

  name                 = var.subnet_privatelink_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.subnet_privatelink_prefixes

}

# Associação NSG à subnet, usando a subnet criada ou a existente
resource "azurerm_subnet_network_security_group_association" "nsg_association_privatelink" {
  subnet_id = coalesce(
    try(azurerm_subnet.subnet_privatelink[0].id, null),
    try(data.azurerm_subnet.subnet_privatelink[0].id, null)
  )
  network_security_group_id = var.network_security_group_id
}


