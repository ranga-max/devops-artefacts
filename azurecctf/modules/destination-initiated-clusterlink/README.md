## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_confluent"></a> [confluent](#requirement\_confluent) | 1.68.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_confluent"></a> [confluent](#provider\_confluent) | 1.68.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [confluent_cluster_link.destination-outbound](https://registry.terraform.io/providers/confluentinc/confluent/1.68.0/docs/resources/cluster_link) | resource |
| [confluent_kafka_cluster.destination](https://registry.terraform.io/providers/confluentinc/confluent/1.68.0/docs/data-sources/kafka_cluster) | data source |
| [confluent_kafka_cluster.source](https://registry.terraform.io/providers/confluentinc/confluent/1.68.0/docs/data-sources/kafka_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_link_name"></a> [cluster\_link\_name](#input\_cluster\_link\_name) | Name of the Cluster Link to create | `string` | `"destination-initiated-cluster-link-terraform"` | no |
| <a name="input_confluent_cloud_api_key"></a> [confluent\_cloud\_api\_key](#input\_confluent\_cloud\_api\_key) | Confluent Cloud API Key (also referred as Cloud API ID) | `string` | n/a | yes |
| <a name="input_confluent_cloud_api_secret"></a> [confluent\_cloud\_api\_secret](#input\_confluent\_cloud\_api\_secret) | Confluent Cloud API Secret | `string` | n/a | yes |
| <a name="input_destination_kafka_cluster_environment_id"></a> [destination\_kafka\_cluster\_environment\_id](#input\_destination\_kafka\_cluster\_environment\_id) | ID of the Environment that the Destination Kafka Cluster belongs to | `string` | n/a | yes |
| <a name="input_destination_kafka_cluster_id"></a> [destination\_kafka\_cluster\_id](#input\_destination\_kafka\_cluster\_id) | ID of the Destination Kafka Cluster | `string` | n/a | yes |
| <a name="input_kafka_destination_api_key"></a> [kafka\_destination\_api\_key](#input\_kafka\_destination\_api\_key) | Confluent Cluster API Key | `string` | n/a | yes |
| <a name="input_kafka_destination_api_secret"></a> [kafka\_destination\_api\_secret](#input\_kafka\_destination\_api\_secret) | Confluent Cluster API secret | `string` | n/a | yes |
| <a name="input_kafka_source_api_key"></a> [kafka\_source\_api\_key](#input\_kafka\_source\_api\_key) | Confluent Cluster API Key | `string` | n/a | yes |
| <a name="input_kafka_source_api_secret"></a> [kafka\_source\_api\_secret](#input\_kafka\_source\_api\_secret) | Confluent Cluster API secret | `string` | n/a | yes |
| <a name="input_source_kafka_cluster_environment_id"></a> [source\_kafka\_cluster\_environment\_id](#input\_source\_kafka\_cluster\_environment\_id) | ID of the Environment that the Source Kafka Cluster belongs to | `string` | n/a | yes |
| <a name="input_source_kafka_cluster_id"></a> [source\_kafka\_cluster\_id](#input\_source\_kafka\_cluster\_id) | ID of the Source Kafka Cluster | `string` | n/a | yes |
