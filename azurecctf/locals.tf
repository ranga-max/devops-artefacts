#locals {
#  hosted_zone = length(regexall(".glb", module.confluent_cluster.bootstrap_endpoint)) > 0 ? replace(regex("^[^.]+-([0-9a-zA-Z]+[.].*):[0-9]+$", module.confluent_cluster.rest_endpoint)[0], "glb.", "") : regex("[.]([0-9a-zA-Z]+[.].*):[0-9]+$", confluent_kafka_cluster.azure-dedicated-dev.bootstrap_endpoint)[0]
#  network_id  = regex("^([^.]+)[.].*", local.hosted_zone)[0]
#}

locals {
  kafka_cluster_id = module.confluent_cluster.kafka_cluster_id
}   