output "service_account_ids" {
  description = "Map of service account display names to their IDs"
  value       = { for key, sa in confluent_service_account.confluentPS-sa : key => sa.id }
}


output "service_account_api_keys" {
 description = "api keys of the service accouts"
 value       =  confluent_api_key.kafka-api-keys
}

output "app-manager-display_name" {
  value = confluent_service_account.confluentPS-sa["rrchakapp1-app-manager"].display_name
}

output "app-producer-display_name" {
  value = confluent_service_account.confluentPS-sa["rrchakapp1-app-producer"].display_name
}

output "app-consumer-display_name" {
  value = confluent_service_account.confluentPS-sa["rrchakapp1-app-consumer"].display_name
}

output "sa-ids" {
  value = [ for key, sa in confluent_service_account.confluentPS-sa : sa.id ]
}

output "app-manager-id" {
  value = confluent_service_account.confluentPS-sa["rrchakapp1-app-manager"].id
}

output "app-producer-id" {
  value = confluent_service_account.confluentPS-sa["rrchakapp1-app-producer"].id
}

output "app-consumer-id" {
  value = confluent_service_account.confluentPS-sa["rrchakapp1-app-consumer"].id
}

output "app-manager-kafka-api-key-id" {
   value = confluent_api_key.kafka-api-keys["rrchakapp1-app-manager"].id
}

output "app-producer-kafka-api-key-id" {
   value = confluent_api_key.kafka-api-keys["rrchakapp1-app-producer"].id
}

output "app-consumer-kafka-api-key-id" {
   value = confluent_api_key.kafka-api-keys["rrchakapp1-app-consumer"].id
}

output "app-manager-kafka-api-key-secret" {
 value = confluent_api_key.kafka-api-keys["rrchakapp1-app-manager"].secret
}

output "app-producer-kafka-api-key-secret" {
 value = confluent_api_key.kafka-api-keys["rrchakapp1-app-producer"].secret
}

output "app-consumer-kafka-api-key-secret" {
 value = confluent_api_key.kafka-api-keys["rrchakapp1-app-consumer"].secret
}

output "kafka-api-keys" {
 value = confluent_api_key.kafka-api-keys
}