#Test Localy here and port it to CICD repo 
# Establish all resources atleast key resources; Understand about the resources you are deploying
# Understand Relationships and Arguments/Properties; Incrementally add properties from  basic ones required as you identify
# Understand Syntax Semantics..for e.g. for each etc Complex Simple Data Structures the forms they take..rules for tf is pretty simple
# Try minimal yet effective approach first
# Manage Multiple Instances using counf and for each "for_each" set, its attributes must be accessed on specific instances.
# Group Similar Approaches together; Join the beads; Continuous Incremental Bargining; Pin your ideas first
# Get prspective on N/W resources within cloud providers
# Cause the distuprtion; Understand how you chain root and child module; vars and arguments in root and child
# Understand minimal Inputs you provide to creaate the resources
# Have an idea Paint your picture Build the blocks
# Look for patterns reusable scalable
//what you see you bring alive

# Resource Group
#resource "azurerm_resource_group" "rg" {
#  location = var.resource_group_location
#  name     = "${random_pet.prefix.id}-rg"
#}

//Consume it here

//Create Resource Group

resource "azurerm_resource_group" "rg" {
  location = var.rg_location
  #name     = "test-${random_id.rg_name.hex}-rg"
  name     = var.rg_name
  tags                = merge({ "Name" = format("%s", var.rg_name) }, var.tags, )
  lifecycle {
    prevent_destroy = true
  }
}

// Create Virtual Network

resource "azurerm_virtual_network" "my_azure_vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  #location           = var.vnet_location
  location            = var.rg_location
  dns_servers         = var.vnetdnsservers
  resource_group_name = azurerm_resource_group.rg.name
  tags                = merge({ "Name" = format("%s", var.vnet_name) }, var.tags, )
}

# Private Subnets
#resource "azurerm_subnet" "privatesubnets" {
#  for_each             = var.privatesubnets
#  name                 = each.value.name
#  address_prefixes     = each.value.address
#  resource_group_name  = azurerm_resource_group.rg.name
#  virtual_network_name = azurerm_virtual_network.my_azure_vnet.name
#}

// Create Private Subnet - The Count Way

resource "azurerm_subnet" "privatesubnets_count" {
  count = var.use_for_each ? 0 : length(var.subnet_names)
  address_prefixes                               = [var.subnet_prefixes[count.index]]
  name                                           = var.subnet_names[count.index]
  resource_group_name                            = azurerm_resource_group.rg.name
  virtual_network_name                           = azurerm_virtual_network.my_azure_vnet.name
  private_endpoint_network_policies_enabled = lookup(var.subnet_enforce_private_link_endpoint_network_policies, var.subnet_names[count.index], false)
  private_link_service_network_policies_enabled  = lookup(var.subnet_enforce_private_link_service_network_policies, var.subnet_names[count.index], false)
  service_endpoints                              = lookup(var.subnet_service_endpoints, var.subnet_names[count.index], null)
}

// Create Public Subnet -- The For Each Way

resource "azurerm_subnet" "privatesubnets_foreach" {
  for_each = var.use_for_each ? toset(var.subnet_names) : []
  address_prefixes                               = [local.subnet_names_prefixes[each.value]]
  name                                           = each.value
  resource_group_name                            = azurerm_resource_group.rg.name
  virtual_network_name                           = azurerm_virtual_network.my_azure_vnet.name
  private_endpoint_network_policies_enabled      = lookup(var.subnet_enforce_private_link_endpoint_network_policies, each.value, false)
  private_link_service_network_policies_enabled  = lookup(var.subnet_enforce_private_link_service_network_policies, each.value, false)
  service_endpoints                              = lookup(var.subnet_service_endpoints, each.value, null)
  //no need of subnet delegation for now
}

locals {
  azurerm_subnets = var.use_for_each ? [for s in azurerm_subnet.privatesubnets_foreach : s] : [for s in azurerm_subnet.privatesubnets_count : s]
  azurerm_subnets_name_id_map = {
    for index, subnet in local.azurerm_subnets :
    subnet.name => subnet.id
  }
}


// Create Public Subnets the for each way
resource "azurerm_subnet" "publicsubnets" {
  for_each             = var.publicsubnets
  name                 = each.value.name
  address_prefixes     = [each.value.address]
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my_azure_vnet.name
}

#resource "random_id" "rg_name" {
#  byte_length = 8
#}


resource "azurerm_network_security_group" "nsg1" {
  #location            = var.vnet_location
  location            = var.rg_location
  name                = "test-${azurerm_resource_group.rg.name}-nsg"
  resource_group_name = azurerm_resource_group.rg.name
}

#Create a route table
#Create a route
#Associate a route table to a subnet


#resource "azurerm_route_table" "publicroutetable" {
#  location            = var.rg_location
# name                = "public-${azurerm_resource_group.rg.name}-rt"
# resource_group_name = azurerm_resource_group.rg.name
#}

// Create Private Route table

resource "azurerm_route_table" "privateroutetable" {
  location            = var.rg_location
  name                = "private-${azurerm_resource_group.rg.name}-rt"
  resource_group_name = azurerm_resource_group.rg.name

#  route {
#    name           = "example-route-2"
#    address_prefix = var.vnet_address_space
#    next_hop_type  = "VnetLocal"
#  }
#
}

// Create Private Routes

resource "azurerm_route" "privateroute" {
  address_prefix      = "10.0.0.0/16"
  name                = "acceptanceTestRoute1"
  next_hop_type       = "VnetLocal"
  resource_group_name = azurerm_resource_group.rg.name
  route_table_name    = azurerm_route_table.privateroutetable.name
}

#resource "azurerm_subnet_route_table_association" "publicrouteassociation" {
#  for_each       = var.publicsubnets 
#  subnet_id      = azurerm_subnet.publicsubnets[each.key].id
#  route_table_id = azurerm_route_table.example.id
#}

// Create Private Subnet Route Table Association

resource "azurerm_subnet_route_table_association" "privaterouteassociation" {
  for_each       = local.azurerm_subnets_name_id_map
  //subnet_id      = azurerm_subnet.privatesubnets[each.key].id
  subnet_id      = local.azurerm_subnets_name_id_map[each.key]
  route_table_id = azurerm_route_table.privateroutetable.id
}

// Create Network Security Group

resource "azurerm_network_security_group" "ssh" {
  location            = var.rg_location
  name                = "ssh"
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    access                     = "Allow"
    destination_address_prefix = "*"
    destination_port_range     = "22"
    direction                  = "Inbound"
    name                       = "sshrule"
    priority                   = 100
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
  }
}

#-----------------------------------------------
# Network security group - Default is "false"
#-----------------------------------------------
resource "azurerm_network_security_group" "nsg" {
  #for_each            = var.subnets
  #for_each            = var.nsgrules //not going ny nsg rules
  for_each            = local.subnet_names_nsgs
  name                = lower("nsg_${each.key}_in")
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.rg_location
  tags                = merge({ "ResourceName" = lower("nsg_${each.key}_in") }, var.tags, )
  dynamic "security_rule" {
    for_each = concat(lookup(local.nsgrules[each.value], "nsg_inbound_rules", []), lookup(local.nsgrules[each.value], "nsg_outbound_rules", []))
    content {
      name                       = security_rule.value[0] == "" ? "Default_Rule" : security_rule.value[0]
      priority                   = security_rule.value[1]
      direction                  = security_rule.value[2] == "" ? "Inbound" : security_rule.value[2]
      access                     = security_rule.value[3] == "" ? "Allow" : security_rule.value[3]
      protocol                   = security_rule.value[4] == "" ? "Tcp" : security_rule.value[4]
      source_port_range          = "*"
      destination_port_range     = security_rule.value[5] == "" ? "*" : security_rule.value[5]
      source_address_prefix      = security_rule.value[6] == "" ? local.subnet_names_prefixes[each.key] : security_rule.value[6]
      destination_address_prefix = security_rule.value[7] == "" ? local.subnet_names_prefixes[each.key] : security_rule.value[7]
      description                = "${security_rule.value[2]}_Port_${security_rule.value[5]}"
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-assoc" {
   for_each       = local.subnet_names_nsgs
   subnet_id      = local.azurerm_subnets_name_id_map[each.key]
   network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}

#nsg_ids = {
#    subnet1 = azurerm_network_security_group.ssh.id
#    subnet2 = azurerm_network_security_group.ssh.id
#    subnet3 = azurerm_network_security_group.ssh.id
#  }

#Associate Network Security Groups with public subnet

resource "azurerm_subnet_network_security_group_association" "vnet" {
  #for_each = var.nsg_ids
  for_each = var.publicsubnets   
  #network_security_group_id = each.value
  network_security_group_id=azurerm_network_security_group.ssh.id
  #subnet_id                 = local.azurerm_subnets_name_id_map[each.key]
  subnet_id                  = azurerm_subnet.publicsubnets[each.key].id
}

// Create DDOS plan 

#resource "azurerm_network_ddos_protection_plan" "ddosplan" {
#  location            = var.rg_location
#  name                = "${azurerm_resource_group.rg.name}-protection-plan"
#  resource_group_name = azurerm_resource_group.rg.name
#}

/* Create public IP
resource "azurerm_public_ip" "eip" {
  name                = "${azurerm_resource_group.rg.name}-Public-IP"
  location            = var.rg_location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = [1]
}

 Create NatGateway
resource "azurerm_nat_gateway" "ngway" {
  location            = var.rg_location
  name                = "${azurerm_resource_group.rg.name}-natgateway"
  resource_group_name = azurerm_resource_group.rg.name
}

# Nat - Public IP Association
resource "azurerm_nat_gateway_public_ip_association" "this" {
 nat_gateway_id       = azurerm_nat_gateway.this.id
 public_ip_address_id = azurerm_public_ip.this.id
}

# NAT - Subnets association
resource "azurerm_subnet_nat_gateway_association" "this" {
 for_each       = var.privatesubnets 
 #subnet_id      = azurerm_subnet.private.id
 subnet_id      = azurerm_subnet.privatesubnets[each.key].id
 nat_gateway_id = azurerm_nat_gateway.ngway.id
} */








