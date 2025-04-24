variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key (also referred as Cloud API ID)"
  type        = string
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret"
  type        = string
  sensitive   = true
}


variable "env_confluentPS_id" {
  description = "Confluent Environment ID)"
  type        = string
}

variable "cluster_confluentPS_id" {
  description = "Confluent Cluster confluentPS ID"
  type        = string
}

#variable "kafka_rest_endpoint" {
#  description = "Confluent Cluster REST Endpoint"
#  type        = string
#}

#variable "kafka_api_key" {
#  description = "Confluent Cluster API Key"
#  type        = string
#}

#variable "kafka_api_secret" {
#  description = "Confluent Cluster API secret"
#  type        = string
#}

#variable "data_test_topic" {
#  description = "Topic for JDBC connect data"
#  type        = string
#}

variable "topics" {
  type = map(object({
    partitions_count = number
    cleanup_policy   = string
  }))
}

variable "kafka_api_keys" {
  type        = map(any)
  default     = {}
  description = "A map of kafka_api_keys data for all service accounts"
}

variable "service_accounts" {
  type = map(object({
    display_name = string
    role_definitions = list(object({
      role_name   = string
      crn_pattern = string
    }))
  }))
}

variable "sa-ids" {
  type = list(string)
}

