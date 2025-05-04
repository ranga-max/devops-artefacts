output "storage_account_name" {
  value = azurerm_storage_account.primary.name
}

output "storage_account_id" {
    value = azurerm_storage_account.primary.id
}

output "storage_dns_a_record" {
  value = azurerm_private_dns_a_record.dns_a.fqdn
}

output "storage_ip_address" {
  value = azurerm_private_endpoint.endpoint.private_service_connection.0.private_ip_address
}

output "storage_primary_access_key" {
    value = nonsensitive(azurerm_storage_account.primary.primary_access_key)
}

output "storage_primary_connection_string" {
  value = nonsensitive(azurerm_storage_account.primary.primary_connection_string)
}