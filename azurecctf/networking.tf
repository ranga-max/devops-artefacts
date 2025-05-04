module "Networking" {
source              = "./modules/Networking"
rg_name             = var.rg_name
rg_location         = var.rg_location
vnet_name           = var.vnet_name
use_for_each        = var.use_for_each
vnet_address_space  = var.vnet_address_space
subnet_service_endpoints = var.subnet_service_endpoints
#vnetdnsservers      = var.vnetdnsservers
#subnet_enforce_private_link_endpoint_network_policies = var.subnet_enforce_private_link_endpoint_network_policies
#subnet_enforce_private_link_service_network_policies = var.subnet_enforce_private_link_service_network_policies
nsgrules            = var.nsgrules  
subnet_nsgs         = var.subnet_nsgs     
subnet_prefixes     = var.subnet_prefixes
subnet_names        = var.subnet_names
publicsubnets       = var.publicsubnets
#count_subnets       = "${length(var.subnet_prefix)}"
#subnet_name         = "${lookup(element(var.subnet_prefix, count.index), "name")}"
#address_prefix      = "${lookup(element(var.subnet_prefix, count.index), "ip")}"
tags = var.tags
#count = var.enable_networking_module ? 1 : 0
}

module "Compute" {
source              = "./modules/Compute"
rg_name             = var.rg_name
rg_location         = var.rg_location
vnet_name           = var.vnet_name
vm_node_name = var.vm_node_name
key_name = var.key_name
vm-count = var.public-vm-count
vm_type = "public"
owner-name     = var.owner-name
vm_instance_type    = var.vm_instance_type
publicsubnets = var.publicsubnets
nsg_inbound_rules = var.nsg_inbound_rules_public
data_disks   =  var.data_disks
admin_username   = var.admin_username
//admin_password = var.admin_password
linux_distribution_name = var.linux_distribution_name
admin_ssh_key_data = var.admin_ssh_key_data
generate_admin_ssh_key  = false
tags = {
    Env          = "dev"
    owner_name   = "rravathanaloorc@confluent.io"
  }
#count = var.enable_compute_module ? 1 : 0  
#depends_on = [module.Networking]  
}
