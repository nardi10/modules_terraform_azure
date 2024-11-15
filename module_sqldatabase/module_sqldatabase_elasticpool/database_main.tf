resource "azurerm_mssql_database" "sqldatabase" {
  name         = var.database_name
  server_id    = var.sqlserver_id
  collation    = var.database_collation
  license_type = "LicenseIncluded"
  #max_size_gb    = var.max_size_gb
  sku_name                            = var.database_sku_name
  elastic_pool_id = var.elastic_pool_id
  zone_redundant                      = false
  storage_account_type                = "Local"
  transparent_data_encryption_enabled = true

  tags = merge(var.tags, {
    Terraform = "Yes"
  })
}