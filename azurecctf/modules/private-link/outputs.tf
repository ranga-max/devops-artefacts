output "confluent_network_id" {
  value = confluent_network.private-link.id
}

output "hosted_zone" {
  value = local.hosted_zone
}