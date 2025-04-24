
data "confluent_environment" "env_confluentPS" {
  id = var.env_confluentPS_id
}

data "confluent_kafka_cluster" "cluster_confluentPS" {
  id = var.cluster_confluentPS_id
  environment {
    id = data.confluent_environment.env_confluentPS.id
  }
}

data "confluent_service_account" "confluentPS-sa" {
  #for_each     = var.service_accounts
  #id = each.key
  for_each     = var.service_accounts
  display_name = each.value.display_name
}

locals {
    kafka_api_keys = var.kafka_api_keys
}


// Provisioning Kafka Topics requires access to the REST endpoint on the Kafka cluster
// If Terraform is not run from within the private network, this will not work

resource "confluent_kafka_topic" "confluentPS_test" {
  kafka_cluster {
    id = data.confluent_kafka_cluster.cluster_confluentPS.id
  }
  for_each = var.topics

  topic_name       = each.key
  partitions_count = each.value.partitions_count
  # Additional configuration options

  rest_endpoint = data.confluent_kafka_cluster.cluster_confluentPS.rest_endpoint
  config = {
    "cleanup.policy" = each.value.cleanup_policy
  }
  credentials {
    key    = local.kafka_api_keys["rrchakapp1-app-consumer"].id
    secret = local.kafka_api_keys["rrchakapp1-app-consumer"].secret
  }
}
