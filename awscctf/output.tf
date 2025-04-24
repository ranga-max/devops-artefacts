output "vpc_id" {
  value = module.Networking.vpc_id
}

output "public_subnets_id" {
  value = module.Networking.public_subnets_id
}

output "private_subnets_id" {
  value = module.Networking.private_subnets_id
}

output "default_sg_id" {
  value = module.Networking.default_sg_id
}

output "public_route_table" {
  value = module.Networking.public_route_table
}

output "confluent_network_id" {
  value = module.confluent_network_private_link.confluent_network_id
}


#output "resource-ids" {
#  value = module.confluent_cluster.resource-ids
#  sensitive = true
#}

output "kafka_cluster_id" {
     value = module.confluent_cluster.kafka_cluster_id
}

output "kafka_cluster_api_version" {
     value = module.confluent_cluster.kafka_cluster_api_version
}

output "kafka_cluster_kind" {
     value = module.confluent_cluster.kafka_cluster_kind
}

output "bootstrap_endpoint" {
     value = module.confluent_cluster.bootstrap_endpoint
}

output "rest_endpoint" {
     value = module.confluent_cluster.rest_endpoint
}

#Uncomment output for a respective module as you keep adding it into the main folder
output "resource-ids" {
  value = <<-EOT
  Environment ID:   ${data.confluent_environment.env_confluentPS.id}
  Kafka Cluster ID: ${module.confluent_cluster.kafka_cluster_id}

  Service Accounts and their Kafka API Keys (API Keys inherit the permissions granted to the owner):
  ${module.service_accounts.app-manager-display_name}:                     ${module.service_accounts.app-manager-id}
  ${module.service_accounts.app-manager-display_name}'s Kafka API Key:     "${module.service_accounts.app-manager-kafka-api-key-id}"
  ${module.service_accounts.app-manager-display_name}'s Kafka API Secret:  "${module.service_accounts.app-manager-kafka-api-key-secret}"

  ${module.service_accounts.app-producer-display_name}:                    ${module.service_accounts.app-producer-id}
  ${module.service_accounts.app-producer-display_name}'s Kafka API Key:    "${module.service_accounts.app-producer-kafka-api-key-id}"
  ${module.service_accounts.app-producer-display_name}'s Kafka API Secret: "${module.service_accounts.app-producer-kafka-api-key-secret}"

  ${module.service_accounts.app-consumer-display_name}:                    ${module.service_accounts.app-consumer-id}
  ${module.service_accounts.app-consumer-display_name}'s Kafka API Key:    "${module.service_accounts.app-consumer-kafka-api-key-id}"
  ${module.service_accounts.app-consumer-display_name}'s Kafka API Secret: "${module.service_accounts.app-consumer-kafka-api-key-secret}"

  
  EOT

  sensitive = true
}

