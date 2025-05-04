variable "vnet_name" {
  description = "Resource Group Name"
}

variable "rg_name" {
  description = "Resource Group Name"
}

variable "rg_location" {
  description = "Resource Group Location"
}

#variable "vnet_address_space" {
#  description = "Address Space or CIDR of VNET"
#}

variable "vnet_address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "The address space that is used by the virtual network."
}

variable "dns_servers" {
  description = "List of dns servers to use for virtual network"
  default     = []
}

variable "subnet_name_by_zone" {
  description = "A map of Zone to Subnet Name"
  type        = map(string)
}

variable "subscription_id" {
  description = "The Azure subscription ID to enable for the Private Link Access where your VNet exists"
  type        = string
}

variable "client_id" {
  description = "The ID of the Client on Azure"
  type        = string
}

variable "client_secret" {
  description = "The Secret of the Client on Azure"
  type        = string
}

variable "tenant_id" {
  description = "The Azure tenant ID in which Subscription exists"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "subnet_names" {
  type        = list(string)
  default     = ["subnet1", "subnet2", "subnet3"]
  description = "A list of public subnets inside the vNet."
}

variable "subnet_prefixes" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  description = "The address prefix to use for the subnet."
}

variable "subnet_nsgs" {
  type        = list(string)
  default     = ["nsgrs1", "nsgrs1", "nsgrs1"]
  description = "The address prefix to use for the subnet."
}

variable "use_for_each" {
  type        = bool
  description = "Use `for_each` instead of `count` to create multiple resource instances."
  nullable    = false
}

variable "publicsubnets" {
  type = map(object({
    name    = string
    address = string
  }))
}

variable "subnet_service_endpoints" {
  type        = map(any)
  default     = {}
  description = "A map of subnet name to service endpoints to add to the subnet."
}

variable "subnet_enforce_private_link_endpoint_network_policies" {
  type        = map(bool)
  default     = {}
  description = "A map of subnet name to enable/disable private link endpoint network policies on the subnet."
}

variable "subnet_enforce_private_link_service_network_policies" {
  type        = map(bool)
  default     = {}
  description = "A map of subnet name to enable/disable private link service network policies on the subnet."
}

variable "nsgrules" {
  type = map(object({
    nsg_inbound_rules  = list(any)
    nsg_outbound_rules = list(any)
  }))
}

variable "node-name" {
  default = "zookeeper"
}

variable "public-vm-count" {
    default = 0
}

variable "zk-count" {
    default = 0
}

variable "broker-count" {
    default = 0
}

variable "connect-count" {
  default = 0
}

variable "schema-count" {
  default = 0
}

variable "rest-count" {
  default = 0
}

variable "c3-count" {
  default = 0
}

variable "ksql-count" {
  default = 0
}

variable "public_vm_nsgs" {
  type        = list(string)
  default     = ["pubnsgrs1"]
  description = "NSG for public VM"
}

variable "private_vm_nsgs" {
  type        = list(string)
  default     = ["prinsgrs1"]
  description = "NSG for Private VM"
}

variable "nsg_inbound_rules_public" {
  description = "List of network rules to apply to network interface."
  default     = []
}


variable "nsg_inbound_rules_private" {
  description = "List of network rules to apply to network interface."
  default     = []
}

variable "admin_ssh_key_data" {
  description = "specify the path to the existing SSH key to authenticate Linux virtual machine"
  default     = null
}


variable "disk_size_gb" {
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
  default     = null
}

variable "admin_username" {
  description = "The username of the local administrator used for the Virtual Machine."
  default     = "azureadmin"
}

variable "linux_distribution_name" {
  default     = "ubuntu1804"
  description = "Variable to pick an OS flavour for Linux based VM. Possible values include: centos8, ubuntu1804"
}

variable "vm_node_name" {
   description = "Prefix of the node name"
}

variable "key_name" {
   description = "SSH Public Key name"
}

variable "vm_instance_type" {
  description = "The Virtual Machine SKU for the Virtual Machine, Default is Standard_A2_V2"
  default     = "Standard_A2_v2"
}

variable "data_disks" {
  description = "Managed Data Disks for azure viratual machine"
  type = list(object({
    name                 = string
    storage_account_type = string
    disk_size_gb         = number
  }))
  default = []
}

variable "vm_type" {
  default = "private"
}

variable "owner-name" {
  default = "Terraform User"
}





