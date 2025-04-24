


data "confluent_environment" "env_confluentPS" {
  id = var.env_confluentPS_id
}


resource "confluent_service_account" "confluentPS-sa" {
  for_each     = var.accounts
  display_name = each.key
  description  = each.value.description
}

/*
data "confluent_service_account" "sa_name" {
  #for_each     = toset(var.sa-ids)
  #id = each.value
  for_each     = var.service_accounts
  display_name = each.value.display_name
}
*/

resource "confluent_api_key" "kafka-api-keys" {
  for_each     = var.accounts
  display_name =  each.key 
  description  = "Kafka API Key that is owned by '${each.key}' service account"

  # Set optional `disable_wait_for_ready` attribute (defaults to `false`) to `true` if the machine where Terraform is not run within a private network
   disable_wait_for_ready = true
  
  
  owner {
    id          = confluent_service_account.confluentPS-sa[each.key].id
    api_version = confluent_service_account.confluentPS-sa[each.key].api_version
    kind        = confluent_service_account.confluentPS-sa[each.key].kind
  }
  

  /*
  owner {
    id          = data.confluent_service_account.sa_name[each.key].id
    api_version = data.confluent_service_account.sa_name[each.key].api_version
    kind        = data.confluent_service_account.sa_name[each.key].kind
  }
  */

  managed_resource {
#    #id          = confluent_kafka_cluster.dedicated.id
    id          = var.kafka_cluster_id
#    #api_version = confluent_kafka_cluster.dedicated.api_version
    api_version = var.kafka_cluster_api_version
#    #kind        = confluent_kafka_cluster.dedicated.kind
    kind         = var.kafka_cluster_kind
    environment {
#      #id = confluent_environment.staging.id
      id = data.confluent_environment.env_confluentPS.id
     }
  }
}

