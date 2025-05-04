
data "confluent_environment" "env_confluentPS" {
  id = var.env_confluentPS_id
}

data "confluent_network" "private-link" {
  id = var.confluent_network_id
  environment {
    id = data.confluent_environment.env_confluentPS.id
  }
}

# Stream Governance and Kafka clusters can be in different regions as well as different cloud providers,
# but you should to place both in the same cloud and region to restrict the fault isolation boundary.
data "confluent_schema_registry_region" "essentials" {
  cloud   = "AWS"
  region  = "us-east-2"
  package = "ESSENTIALS"
}

resource "confluent_schema_registry_cluster" "essentials" {
  package = data.confluent_schema_registry_region.essentials.package

  environment {
    id = data.confluent_environment.env_confluentPS.id
  }

  region {
    # See https://docs.confluent.io/cloud/current/stream-governance/packages.html#stream-governance-regions
    id = data.confluent_schema_registry_region.essentials.id
  }
}

resource "confluent_kafka_cluster" "azure-dedicated-dev" {
  display_name = var.cluster_name
  availability = var.availability_zone
  cloud        = data.confluent_network.private-link.cloud
  region       = data.confluent_network.private-link.region
  dedicated {
    cku = var.cku_number
  }
  environment {
    id = data.confluent_environment.env_confluentPS.id
  }
  network {
    id = data.confluent_network.private-link.id
  }
}
