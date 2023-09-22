resource "azurerm_resource_group" "web-app-rg" {
  name     = "hoopers-webapp-1_group"
  location = "West Europe"
}

resource "azurerm_service_plan" "web-app-plan" {
  name                = "ASP-hooperswebapp1group-a138"
  resource_group_name = azurerm_resource_group.web-app-rg.name
  location            = azurerm_resource_group.web-app-rg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "web-app-1" {
  name                = "hoopers-webapp-1"
  resource_group_name = azurerm_resource_group.web-app-rg.name
  location            = azurerm_service_plan.web-app-plan.location
  service_plan_id     = azurerm_service_plan.web-app-plan.id

  site_config {}
}