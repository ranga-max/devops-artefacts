variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key (also referred as Cloud API ID)"
  type        = string
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret"
  type        = string
  sensitive   = true
}

#variable "env_confluentPS_id" {
#  description = "Entreprise Non Prod Confluent Environment ID"
#  type        = string
#}

#variable "env_entreprise_nprd_id" {
#  description = "Entreprise Non Prod Confluent Environment ID"
#  type        = string
#}

#variable "confluent_network_id" {
#  description = "Confluent Private Link Network for Non Prod Environment ID"
#  type        = string
#}

variable "cluster_name" {
  description = "Name of the Confluent Cloud Kafka cluster"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the Confluent Cloud Kafka cluster"
  type        = string
}

variable "cku_number" {
  description = "CKU number for the cluster"
  type        = number
}

#variable "kafka_api_key" {
#  description = "Confluent Cluster API Key"
#  type        = string
#}

#variable "kafka_api_secret" {
#  description = "Confluent Cluster API secret"
#  type        = string
#}



