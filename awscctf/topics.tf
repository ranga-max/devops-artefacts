module "topics" {
  source                     = "./modules/kafka-topics"
  confluent_cloud_api_key    = var.confluent_cloud_api_key
  confluent_cloud_api_secret = var.confluent_cloud_api_secret
  #accounts                   = var.accounts
  env_confluentPS_id  = data.confluent_environment.env_confluentPS.id
  cluster_confluentPS_id  = module.confluent_cluster.kafka_cluster_id
  kafka_api_keys = module.service_accounts.kafka-api-keys
  topics                     = var.topics
  service_accounts           = var.service_accounts
  sa-ids = module.service_accounts.sa-ids
}