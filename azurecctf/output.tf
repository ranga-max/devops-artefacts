output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = module.Networking.vnet_address_space
}

output "vnet_guid" {
  description = "The GUID of the newly created vNet"
  value       = module.Networking.vnet_guid
}

output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = module.Networking.vnet_id
}

output "vnet_location" {
  description = "The location of the newly created vNet"
  value       = module.Networking.vnet_location
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = module.Networking.vnet_name
}

output "vnet_private_subnets" {
  description = "The ids of subnets created inside the newly created vNet"
  value       = module.Networking.vnet_private_subnets
}

output "vnet_public_subnets" {
  description = "The ids of subnets created inside the newly created vNet"
  value       = module.Networking.vnet_public_subnets
}

output "vnet_subnets_name_id" {
  description = "Can be queried subnet-id by subnet name by using lookup(module.vnet.vnet_subnets_name_id, subnet1)"
  value       = module.Networking.vnet_subnets_name_id
}

output "subnet_names_prefixes" {
  value = module.Networking.subnet_names_prefixes
  description = "Local Version"
} 

//output "vm_admin_ssh_key_public" {
//  description = "The generated public key data in PEM format"
//  value       = module.Compute.admin_ssh_key_public
//}

//output "vm_admin_ssh_key_private" {
//  description = "The generated private key data in PEM format"
//  sensitive   = true
//  value       = module.Compute.admin_ssh_key_private
//}

//output "vm_linux_vm_password" {
//  description = "Password for the Linux VM"
//  sensitive   = true
//  value       = module.Compute.linux_vm_password
//}

output "vm_linux_vm_public_ips" {
  description = "Public IP's map for the all windows Virtual Machines"
  value       = module.Compute.linux_vm_public_ips
}

output "vm_linux_vm_private_ips" {
  description = "Public IP's map for the all windows Virtual Machines"
  value       = module.Compute.linux_vm_private_ips
}

output "vm_linux_virtual_machine_ids" {
  description = "The resource id's of all Linux Virtual Machine."
  value       = module.Compute.linux_virtual_machine_ids
}

output "vm_network_security_group_ids" {
  description = "List of Network security groups and ids"
  value       = module.Compute.network_security_group_ids
}

output "env_confluentPS" {
  description = "Enironment ID within Confluent Cloud"  
  value = confluent_environment.env_confluentPS.id
}

#output "service_accounts" {
#   description = "Enironment ID within Confluent Cloud"  
#   value = module.service_accounts.service_account_api_keys

#   sensitive = true
#}

output "hosted_zone" {
  value       = module.confluent_network_private_link.hosted_zone
}


output "storage_account_name" {
  value = module.azure-blobs.storage_account_name
}

output "storage_account_id" {
    value = module.azure-blobs.storage_account_id
}

output "storage_dns_a_record" {
  value = module.azure-blobs.storage_dns_a_record
}

output "storage_ip_address" {
  value = module.azure-blobs.storage_ip_address
}

output "storage_primary_access_key" {
    value = module.azure-blobs.storage_primary_access_key
}

output "storage_primary_connection_string" {
  value = module.azure-blobs.storage_primary_connection_string
}

output "sr_service_account_api_keys" {
  value = module.sr_service_accounts.sr_service_account_api_keys
  sensitive = true
}



