//Declare it here

variable "vnet_name" {
  description = "Resource Group Name"
}

variable "rg_name" {
  description = "Resource Group Name"
}

variable "rg_location" {
  description = "Resource Group Location"
}

variable "vnet_address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "The address space that is used by the virtual network."
}

variable "publicsubnets" {
  type = map(object({
    name    = string
    address = string
  }))
}

#variable "count_subnet" {
#  description = "count"
#}

#variable "address_prefix" {
#  description = "IP Address prefix"
#}

variable "use_for_each" {
  type        = bool
  description = "Use `for_each` instead of `count` to create multiple resource instances."
  nullable    = false
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

variable "tags" {
  type = map(string)
  default = {
    ENV = "test"
  }
  description = "The tags to associate with your network and subnets."
}

variable "nsg_ids" {
  type = map(string)
  default = {
  }
  description = "A map of subnet name to Network Security Group IDs"
}

variable "route_tables_ids" {
  type        = map(string)
  default     = {}
  description = "A map of subnet name to Route table ids"
}

variable "subnet_service_endpoints" {
  type        = map(any)
  default     = {}
  description = "A map of subnet name to service endpoints to add to the subnet."
}

variable "vnetdnsservers" {
  type        = list(string)
  default     = []  
  description = "VNET DNS Server"
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

variable "dns_servers" {
  description = "List of dns servers to use for virtual network"
  default     = []
}

variable "nsgrules" {
  type = map(object({
    nsg_inbound_rules  = list(any)
    nsg_outbound_rules = list(any)
  }))
}