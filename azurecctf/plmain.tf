#data "confluent_kafka_cluster" "source" {
#  id = local.source_kafka_cluster_id
#  environment {
#    id = local.source_kafka_cluster_environment_id
#  }
#}

#Imp Note : Be careful while adding depends on as it might unnecessarily recreate all upstream resources/modulee
#when you appy a new downstream module for which the dependent resource have already been created

module "confluent_network_private_link" {
  source = "./modules/private-link"

  env_confluentPS_id  = data.confluent_environment.env_confluentPS.id
  region              = var.rg_location
  subscription_id     = var.subscription_id
  resource_group      = var.rg_name
  vnet_name           = var.vnet_name
  subnet_name_by_zone = var.subnet_name_by_zone
  hosted_zone  = local.hosted_zone
  network_id = local.network_id
  #client_id           = var.client_id
  #client_secret       = var.client_secret
  #tenant_id           = var.tenant_id
  #count = var.enable_pl_module ? 1 : 0
  #depends_on = [module.Networking, module.Compute] 
}