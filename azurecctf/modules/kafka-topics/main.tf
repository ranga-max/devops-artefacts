
data "confluent_environment" "env_confluentPS" {
  id = var.env_confluentPS_id
}

data "confluent_kafka_cluster" "cluster_confluentPS" {
  id = var.cluster_confluentPS_id
  environment {
    id = data.confluent_environment.env_confluentPS.id
  }
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
}
