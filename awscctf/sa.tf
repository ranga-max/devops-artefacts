module "service_accounts" {
  source                     = "./modules/kafka-sa"
  confluent_cloud_api_key    = var.confluent_cloud_api_key
  confluent_cloud_api_secret = var.confluent_cloud_api_secret
  accounts                   = var.accounts
  env_confluentPS_id  = data.confluent_environment.env_confluentPS.id
  kafka_cluster_id  = module.confluent_cluster.kafka_cluster_id
  kafka_cluster_api_version = module.confluent_cluster.kafka_cluster_api_version
  kafka_cluster_kind = module.confluent_cluster.kafka_cluster_kind
}