terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

resource "random_string" "suffix" {
  length = 4
  upper = false
  special = false
  numeric = false
}

data "azurecaf_name" "func_app_name" {
  resource_type = "azurerm_windows_function_app"
  suffixes = [ var.solution_name, var.location, var.environment, random_string.suffix.result ]
}

resource "azurerm_windows_function_app" "function_app" {
  app_settings = var.app_settings
  location = var.location
  resource_group_name = var.resource_group_name
  name = data.azurecaf_name.func_app_name.result
  https_only = var.https_only
  ftp_publish_basic_authentication_enabled = var.ftp_publish_basic_authentication
  virtual_network_subnet_id = var.vnet_integration_subnet_id
  storage_account_name = var.storage_account_name != null ? var.storage_account_name : null
  storage_account_access_key = var.storage_account_access_key != null ? var.storage_account_name : null
  identity {
    type = "SystemAssigned"
  }
  site_config {
    minimum_tls_version = "1.2"
    dynamic "ip_restriction" {
      for_each = { for k, v in var.ip_restrictions : k => v }
      content {
        action = ip_restriction.value.action
        name = ip_restriction.value.name
        ip_address = ip_restriction.value.ip_address
        priority = ip_restriction.value.priority
      }
    }
  }
  functions_extension_version = var.functions_extension_version
  service_plan_id = var.app_service_plan_id
}

resource "azurerm_private_endpoint" "pep" {
  name = "pe-func-${var.solution_name}-${var.location}-${var.environment}"
  resource_group_name = var.resource_group_name
  location = var.location
  subnet_id = var.private_endpoint_subnet_id
  private_service_connection {
    name = "connection-pe-func-${var.solution_name}-${var.location}-${var.environment}"
    private_connection_resource_id = azurerm_windows_function_app.function_app.id
    subresource_names = ["sites"]
    is_manual_connection = false
  }
  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = var.private_dns_zone_ids
  }
  depends_on = [ azurerm_windows_function_app.function_app ]
}
