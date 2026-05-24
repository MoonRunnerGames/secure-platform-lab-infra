locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${local.name_prefix}"
  location = var.location
}