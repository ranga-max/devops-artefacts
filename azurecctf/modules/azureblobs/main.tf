data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

# Create Azure Storage Account required for Function App
resource azurerm_storage_account "primary" {
  name                     = "rrchakadlsstorage"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create Azure Storage Account Network Rules
resource "azurerm_storage_account_network_rules" "rules" {
  storage_account_id = azurerm_storage_account.primary.id
  
  default_action = "Deny"
  bypass         = ["Metrics", "Logging", "AzureServices"]
}

resource "azurerm_private_endpoint" "endpoint" {
  name                = "rrchakadls_pe"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "adls_psc"
    private_connection_resource_id = azurerm_storage_account.primary.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
}

# Create Private DNS Zone
resource "azurerm_private_dns_zone" "dns-zone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Create DNS A Record
resource "azurerm_private_dns_a_record" "dns_a" {
  name                = "rrchakadls_psc_dnsrecord"
  zone_name           = azurerm_private_dns_zone.dns-zone.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.endpoint.private_service_connection.0.private_ip_address]
}


/*
resource azurerm_storage_container "myblobs" {
  name                  = "myblobs"
  storage_account_name  = azurerm_storage_account.primary.name
  container_access_type = "private"
}
*/