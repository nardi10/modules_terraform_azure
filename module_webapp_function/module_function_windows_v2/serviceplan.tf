# Se um ID de Service Plan existente for fornecido, este data source será utilizado
data "azurerm_service_plan" "asp" {
  count = var.service_plan_id != null ? 1 : 0

  name                = split("/", var.service_plan_id)[8]
  resource_group_name = split("/", var.service_plan_id)[4]
}

# Se o ID de Service Plan for null, será criado um novo Service Plan
resource "azurerm_service_plan" "asp" {
  count = var.service_plan_id == null ? 1 : 0

  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.service_plan_os_type
  sku_name            = var.service_plan_sku_name

  tags = merge(var.tags, {
    Terraform = "Yes"
  })
}
