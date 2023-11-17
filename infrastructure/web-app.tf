resource "azurerm_resource_group" "web_app_rg" {
  name     = "tom-hoopers-rg"
  location = "West Europe"
}

resource "azurerm_service_plan" "web_app_plan" {
  name                = "tom-hoopers-service-plan"
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
    application_stack {
        dotnet_version = "7.0"
    }
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_app_service_source_control" "source_control" {
  app_id   = azurerm_linux_web_app.web_app.id
  repo_url = "https://github.com/tom-hooper-91/asp-hooper"
  branch   = "main"

  github_action_configuration {
    generate_workflow_file = true
    code_configuration {
        runtime_stack = "dotnetcore"
        runtime_version = "7.0"
    }
  }
}

resource "azurerm_source_control_token" "source_control_token" {
  type         = "GitHub"
  token        = var.github_auth_token
}