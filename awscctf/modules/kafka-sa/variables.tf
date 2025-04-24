variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key (also referred as Cloud API ID)"
  type        = string
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret"
  type        = string
  sensitive   = true
}

variable "accounts" {
  type = map(object({
    description = string
  }))
}

variable "env_confluentPS_id" {
  description = "Entreprise Non Prod Confluent Environment ID"
  type        = string
}

variable "kafka_cluster_id" {
  description = "Confluent Kafka Cluster id"
  type        = string
}

variable "kafka_cluster_api_version" {
  description = "Confluent Kafka Api Version"
  type        = string
}

variable "kafka_cluster_kind" {
  description = "Confluent Kafka Cluster Kind"
  type        = string
}


