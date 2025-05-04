output "sr_service_account_ids" {
  description = "Map of service account display names to their IDs"
  value       = { for key, sa in confluent_service_account.confluentPS-sr-sa : key => sa.id }
}

#Service Accounts and their Kafka API Keys (API Keys inherit the permissions granted to the owner):
output "sr_service_account_api_keys" {
  description = "Map of service account display names to their IDs"
  value       = { for key, sa in confluent_api_key.sr-api-keys : key => [sa.id, sa.secret] } 
}
  
