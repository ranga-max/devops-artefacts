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
| [confluent_role_binding.application-role-binding](https://registry.terraform.io/providers/confluentinc/confluent/1.68.0/docs/resources/role_binding) | resource |
| [confluent_environment.env_confluentPS](https://registry.terraform.io/providers/confluentinc/confluent/1.68.0/docs/data-sources/environment) | data source |
| [confluent_kafka_cluster.cluster_confluentPS](https://registry.terraform.io/providers/confluentinc/confluent/1.68.0/docs/data-sources/kafka_cluster) | data source |
| [confluent_service_account.sa_name](https://registry.terraform.io/providers/confluentinc/confluent/1.68.0/docs/data-sources/service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_confluentPS_id"></a> [cluster\_confluentPS\_id](#input\_cluster\_confluentPS\_id) | Confluent Cluster confluentPS ID | `string` | n/a | yes |
| <a name="input_confluent_cloud_api_key"></a> [confluent\_cloud\_api\_key](#input\_confluent\_cloud\_api\_key) | Confluent Cloud API Key (also referred as Cloud API ID) | `string` | n/a | yes |
| <a name="input_confluent_cloud_api_secret"></a> [confluent\_cloud\_api\_secret](#input\_confluent\_cloud\_api\_secret) | Confluent Cloud API Secret | `string` | n/a | yes |
| <a name="input_env_confluentPS_id"></a> [env\_confluentPS\_id](#input\_env\_confluentPS\_id) | Confluent Environment ID) | `string` | n/a | yes |
| <a name="input_kafka_api_key"></a> [kafka\_api\_key](#input\_kafka\_api\_key) | Confluent Cluster API Key | `string` | n/a | yes |
| <a name="input_kafka_api_secret"></a> [kafka\_api\_secret](#input\_kafka\_api\_secret) | Confluent Cluster API secret | `string` | n/a | yes |
| <a name="input_service_accounts"></a> [service\_accounts](#input\_service\_accounts) | n/a | <pre>map(object({<br>    display_name = string<br>    role_definitions = list(object({<br>      role_name   = string<br>      crn_pattern = string<br>    }))<br>  }))</pre> | n/a | yes |
