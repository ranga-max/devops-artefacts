## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
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
| [confluent_kafka_cluster.azure-dedicated-dev](https://registry.terraform.io/providers/confluentinc/confluent/1.68.0/docs/resources/kafka_cluster) | resource |
| [confluent_environment.env_confluentPS](https://registry.terraform.io/providers/confluentinc/confluent/1.68.0/docs/data-sources/environment) | data source |
| [confluent_network.private-link](https://registry.terraform.io/providers/confluentinc/confluent/1.68.0/docs/data-sources/network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Availability zone for the Confluent Cloud Kafka cluster | `string` | n/a | yes |
| <a name="input_cku_number"></a> [cku\_number](#input\_cku\_number) | CKU number for the cluster | `number` | n/a | yes |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | The ID of the Client on Azure | `string` | n/a | yes |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | The Secret of the Client on Azure | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the Confluent Cloud Kafka cluster | `string` | n/a | yes |
| <a name="input_confluent_cloud_api_key"></a> [confluent\_cloud\_api\_key](#input\_confluent\_cloud\_api\_key) | Confluent Cloud API Key (also referred as Cloud API ID) | `string` | n/a | yes |
| <a name="input_confluent_cloud_api_secret"></a> [confluent\_cloud\_api\_secret](#input\_confluent\_cloud\_api\_secret) | Confluent Cloud API Secret | `string` | n/a | yes |
| <a name="input_confluent_network_id"></a> [confluent\_network\_id](#input\_confluent\_network\_id) | Confluent Private Link Network for Non Prod Environment ID | `string` | n/a | yes |
| <a name="input_env_entreprise_nprd_id"></a> [env\_entreprise\_nprd\_id](#input\_env\_entreprise\_nprd\_id) | Entreprise Non Prod Confluent Environment ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region of your VNet | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | The name of the Azure Resource Group that the virtual network belongs to | `string` | n/a | yes |
| <a name="input_subnet_name_by_zone"></a> [subnet\_name\_by\_zone](#input\_subnet\_name\_by\_zone) | A map of Zone to Subnet Name | `map(string)` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The Azure subscription ID to enable for the Private Link Access where your VNet exists | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The Azure tenant ID in which Subscription exists | `string` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | The name of your VNet that you want to connect to Confluent Cloud Cluster | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource-ids"></a> [resource-ids](#output\_resource-ids) | n/a |
