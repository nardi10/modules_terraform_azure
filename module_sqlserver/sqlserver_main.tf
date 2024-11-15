
resource "azurerm_mssql_server" "sqlserver" {
  name                          = var.sqlserver_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "12.0"
  administrator_login           = var.administrator_login
  administrator_login_password  = var.administrator_login_password
  minimum_tls_version           = "1.2"
  public_network_access_enabled = false

  azuread_administrator {
    login_username = "MSP-DBA"
    object_id      = "5c1ae690-ae30-43b5-9229-d90975d75396"
  }

  tags = merge(var.tags, {
    Terraform = "Yes"
  })
}

