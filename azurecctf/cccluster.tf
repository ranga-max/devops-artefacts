data "confluent_environment" "env_confluentPS" {
  #id = var.env_confluentPS_id
  id = confluent_environment.env_confluentPS.id
}

module "confluent_cluster" {
  source = "./modules/azure-cluster"

  env_confluentPS_id         = data.confluent_environment.env_confluentPS.id
  confluent_cloud_api_key    = var.confluent_cloud_api_key
  confluent_cloud_api_secret = var.confluent_cloud_api_secret
  cluster_name               = var.cluster_name
  availability_zone          = var.availability_zone
  cku_number                 = var.cku_number
  confluent_network_id       = module.confluent_network_private_link.confluent_network_id
  #count = var.enable_cccluster_module ? 1 : 0
}

locals {
  hosted_zone = length(regexall(".glb", module.confluent_cluster.bootstrap_endpoint)) > 0 ? replace(regex("^[^.]+-([0-9a-zA-Z]+[.].*):[0-9]+$", module.confluent_cluster.rest_endpoint)[0], "glb.", "") : regex("[.]([0-9a-zA-Z]+[.].*):[0-9]+$", module.confluent_cluster.bootstrap_endpoint)[0]
  network_id  = regex("^([^.]+)[.].*", local.hosted_zone)[0]
}
