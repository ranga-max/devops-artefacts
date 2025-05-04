output "resource-ids" {
  value = <<-EOT
  Environment ID:   ${data.confluent_environment.env_confluentPS.id}
  Kafka Cluster ID: ${confluent_kafka_cluster.azure-dedicated-dev.id}
  Kafka Bootstrap: ${confluent_kafka_cluster.azure-dedicated-dev.bootstrap_endpoint}

 EOT

  sensitive = true
}

output "kafka_cluster_id" {
     value = confluent_kafka_cluster.azure-dedicated-dev.id
}

output "sr_cluster_id" {
     value = confluent_schema_registry_cluster.essentials.id 
}

output "kafka_cluster_api_version" {
     value = confluent_kafka_cluster.azure-dedicated-dev.api_version
}

output "kafka_cluster_kind" {
     value = confluent_kafka_cluster.azure-dedicated-dev.kind
}

output "bootstrap_endpoint" {
     value = confluent_kafka_cluster.azure-dedicated-dev.bootstrap_endpoint
}

output "rest_endpoint" {
     value = confluent_kafka_cluster.azure-dedicated-dev.rest_endpoint
}
