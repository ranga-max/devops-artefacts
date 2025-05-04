locals {
    source_address_prefix_default = ["0.0.0.0/0"]
    dest_address_prefix_default = ["0.0.0.0/0"]
    subnets = var.vm_type != "public" ? var.subnet_names : [for r in var.publicsubnets : "${r.name}"]
}

locals {
  nsg_inbound_rules = { for idx, security_rule in var.nsg_inbound_rules : security_rule.name => {
    idx : idx,
    security_rule : security_rule,
    }
  }

  vm_data_disks = { for idx, data_disk in var.data_disks : data_disk.name => {
    idx : idx,
    data_disk : data_disk,
    }
  }
}