output "resource-ids" {
  value = <<-EOT
  Environment ID:   ${data.confluent_environment.env_confluentPS.id}
  Kafka Cluster ID: ${confluent_kafka_cluster.aws-dedicated-dev.id}
  Kafka Bootstrap: ${confluent_kafka_cluster.aws-dedicated-dev.bootstrap_endpoint}

 EOT

  sensitive = true
}

output "kafka_cluster_id" {
     value = confluent_kafka_cluster.aws-dedicated-dev.id
}

output "kafka_cluster_api_version" {
     value = confluent_kafka_cluster.aws-dedicated-dev.api_version
}

output "kafka_cluster_kind" {
     value = confluent_kafka_cluster.aws-dedicated-dev.kind
}

output "bootstrap_endpoint" {
     value = confluent_kafka_cluster.aws-dedicated-dev.bootstrap_endpoint
}

output "rest_endpoint" {
     value = confluent_kafka_cluster.aws-dedicated-dev.rest_endpoint
}
