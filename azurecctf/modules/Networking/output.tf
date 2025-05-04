output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = azurerm_virtual_network.my_azure_vnet.address_space
}

output "vnet_guid" {
  description = "The GUID of the newly created vNet"
  value       = azurerm_virtual_network.my_azure_vnet.guid
}

output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = azurerm_virtual_network.my_azure_vnet.id
}

output "vnet_location" {
  description = "The location of the newly created vNet"
  value       = azurerm_virtual_network.my_azure_vnet.location
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = azurerm_virtual_network.my_azure_vnet.name
}

output "vnet_private_subnets" {
  description = "The ids of subnets created inside the newly created vNet"
  value       = ["${local.azurerm_subnets[*].id}"]
}

output "vnet_public_subnets" {
  description = "The ids of public subnets created inside the newly created vNet"
  value       =  [for s in azurerm_subnet.publicsubnets : s.id]
}

output "vnet_subnets_name_id" {
  description = "Can be queried subnet-id by subnet name by using lookup(module.vnet.vnet_subnets_name_id, subnet1)"
  value       = "${local.azurerm_subnets_name_id_map}"
}

output "subnet_names_prefixes" {
  value = "${local.subnet_names_prefixes}"
  description = "Local Version"
} 
