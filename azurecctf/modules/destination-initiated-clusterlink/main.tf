

data "confluent_kafka_cluster" "source" {
  id = var.source_kafka_cluster_id
  environment {
    id = var.source_kafka_cluster_environment_id
  }
}

data "confluent_kafka_cluster" "destination" {
  id = var.destination_kafka_cluster_id
  environment {
    id = var.destination_kafka_cluster_environment_id
  }
}

resource "confluent_cluster_link" "destination-outbound" {
  link_name = var.cluster_link_name
  source_kafka_cluster {
    id                 = data.confluent_kafka_cluster.source.id
    bootstrap_endpoint = data.confluent_kafka_cluster.source.bootstrap_endpoint
    credentials {
      key    = var.kafka_source_api_key
      secret = var.kafka_source_api_secret
    }
  }

  destination_kafka_cluster {
    id            = data.confluent_kafka_cluster.destination.id
    rest_endpoint = data.confluent_kafka_cluster.destination.rest_endpoint
    credentials {
      key    = var.kafka_destination_api_key
      secret = var.kafka_destination_api_secret
    }
  }

  config = {
    "consumer.offset.sync.enable"       = "true"
    "auto.create.mirror.topics.enable"  = "true"
    "auto.create.mirror.topics.filters" = "{ \"topicFilters\": [ {\"name\": \"*\",  \"patternType\": \"LITERAL\",  \"filterType\": \"INCLUDE\"} ] }"
  }
}
