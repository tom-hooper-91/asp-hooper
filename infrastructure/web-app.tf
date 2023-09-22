resource "azurerm_resource_group" "web_app_rg" {
  name     = "tom_hoopers_web_app_group"
  location = "West Europe"
}

resource "azurerm_service_plan" "web_app_plan" {
  name                = "hoopers_service_plan"
  resource_group_name = azurerm_resource_group.web_app_rg.name
  location            = azurerm_resource_group.web_app_rg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "web_app" {
  name                = "hoopers-web-app"
  resource_group_name = azurerm_resource_group.web_app_rg.name
  location            = azurerm_service_plan.web_app_plan.location
  service_plan_id     = azurerm_service_plan.web_app_plan.id

  site_config {
    always_on = false
  }
}