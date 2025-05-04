output "service_account_ids" {
  description = "Map of service account display names to their IDs"
  value       = { for key, sa in confluent_service_account.confluentPS-sa : key => sa.id }
}

output "sa-ids" {
  value = [ for key, sa in confluent_service_account.confluentPS-sa : sa.id ]
}

#output "service_account_api_keys" {
#  description = "api keys of the service accouts"
#  value       =  confluent_api_key.kafka-api-keys
#}