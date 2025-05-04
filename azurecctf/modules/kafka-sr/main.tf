data "confluent_environment" "env_confluentPS" {
  id = var.env_confluentPS_id
}

data "confluent_schema_registry_cluster" "essentials" {
  id = var.sr_cluster_id
  environment {
    id = data.confluent_environment.env_confluentPS.id
  }
}

resource "confluent_service_account" "confluentPS-sr-sa" {
  for_each     = var.sr_accounts
  display_name = each.key
  description  = each.value.description
   lifecycle {
    prevent_destroy = true
  }
}

locals {
  roles = flatten([
    for account_name, account in var.sr_service_accounts : [
      for role in account.role_definitions : {
        account_name = account_name
        role_name    = role.role_name
        crn_pattern  = role.crn_pattern
      }
    ]
  ])
}

resource "confluent_role_binding" "sr-account-role-binding" {
  for_each = {
    for pair in local.roles :
    "${pair.account_name}_${pair.role_name}_${pair.crn_pattern}" => {  
      principal   = "User:${confluent_service_account.confluentPS-sr-sa[pair.account_name].id}"
      #role_name   = pair.role.role_name
      role_name   = pair.role_name
      crn_pattern = format("%s/%s", data.confluent_schema_registry_cluster.essentials.resource_name, "${pair.crn_pattern}")
      #crn_pattern = format("%s/%s", data.confluent_schema_registry_cluster.essentials.resource_name, "subject=*")
    }
  }

  principal   = each.value.principal
  role_name   = each.value.role_name
  crn_pattern = each.value.crn_pattern
}

resource "confluent_api_key" "sr-api-keys" {
  for_each     = var.sr_accounts
  display_name =  each.key 
  description  = "Schema Registry API Key that is owned by '${each.key}' service account"

  # Set optional `disable_wait_for_ready` attribute (defaults to `false`) to `true` if the machine where Terraform is not run within a private network
  disable_wait_for_ready = true

  owner {
     id          = confluent_service_account.confluentPS-sr-sa[each.key].id
     api_version = confluent_service_account.confluentPS-sr-sa[each.key].api_version
     kind        = confluent_service_account.confluentPS-sr-sa[each.key].kind
   }

  managed_resource {
     id          = data.confluent_schema_registry_cluster.essentials.id
     api_version = data.confluent_schema_registry_cluster.essentials.api_version
     kind        = data.confluent_schema_registry_cluster.essentials.kind
     environment {
       id = data.confluent_environment.env_confluentPS.id
      }
   }
   lifecycle {
    prevent_destroy = true
   }
}
