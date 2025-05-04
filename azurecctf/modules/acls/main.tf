
data "confluent_environment" "env_confluentPS" {
  id = var.env_confluentPS_id
}

data "confluent_kafka_cluster" "cluster_confluentPS" {
  id = var.cluster_confluentPS_id
  environment {
    id = var.env_confluentPS_id
  }
}

data "confluent_service_account" "sa_name" {
  for_each     = var.service_accounts
  display_name = each.key
}

locals {
  acls = flatten([
    for account_name, account in var.service_accounts : [
      for acl in account.acl_definitions : {
        account_name = account_name
        acl          = acl
      }
    ]
  ])
}


resource "confluent_kafka_acl" "confluentPS-acls" {
  provider = confluent.kafka
  for_each = {
    for pair in local.acls :
    "${pair.account_name}_${pair.acl.resource_type}_${pair.acl.resource_name}_${pair.acl.pattern_type}_${pair.acl.operation}" => {

      resource_type = pair.acl.resource_type
      resource_name = pair.acl.resource_name
      pattern_type  = pair.acl.pattern_type
      principal     = "User:${data.confluent_service_account.sa_name[pair.account_name].id}"
      host          = pair.acl.host
      operation     = pair.acl.operation
      permission    = pair.acl.permission
    }
  }

  resource_type = each.value.resource_type
  resource_name = each.value.resource_name
  pattern_type  = each.value.pattern_type
  principal     = each.value.principal
  host          = each.value.host
  operation     = each.value.operation
  permission    = each.value.permission
}
