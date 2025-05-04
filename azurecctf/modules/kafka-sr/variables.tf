variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key (also referred as Cloud API ID)"
  type        = string
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret"
  type        = string
  sensitive   = true
}

variable "sr_accounts" {
  type = map(object({
    description = string
  }))
}

variable "sr_service_accounts" {
  type = map(object({
    display_name = string
    role_definitions = list(object({
      role_name   = string
      crn_pattern = string
    }))
  }))
}

variable "env_confluentPS_id" {
  description = "Entreprise Non Prod Confluent Environment ID"
  type        = string
}

variable "sr_cluster_id" {
  description = "Confluent Schema Registry Cluster id"
  type        = string
}
