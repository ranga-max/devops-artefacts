#data "confluent_kafka_cluster" "source" {
#  id = local.source_kafka_cluster_id
#  environment {
#    id = local.source_kafka_cluster_environment_id
#  }
#}

module "confluent_network_private_link" {
  source = "./modules/private-link"

  env_confluentPS_id  = data.confluent_environment.env_confluentPS.id
  region               = var.region
  vpc_id = module.Networking.vpc_id
  aws_account_id = var.aws_account_id
  bootstrap_endpoint  = local.bootstrap_endpoint
  subnets_to_privatelink = module.Networking.subnets_to_privatelink
  depends_on = [module.Networking, module.Compute] 
}