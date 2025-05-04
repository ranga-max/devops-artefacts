module "sr_service_accounts" {
  source                     = "./modules/kafka-sr"
  confluent_cloud_api_key    = var.confluent_cloud_api_key
  confluent_cloud_api_secret = var.confluent_cloud_api_secret
  sr_accounts                   = var.sr_accounts
  sr_service_accounts           = var.sr_service_accounts
  env_confluentPS_id  = data.confluent_environment.env_confluentPS.id
  sr_cluster_id  = module.confluent_cluster.sr_cluster_id
}