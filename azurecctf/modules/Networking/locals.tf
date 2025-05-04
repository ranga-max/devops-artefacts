locals {
  subnet_names_prefixes = zipmap(var.subnet_names, var.subnet_prefixes)
}

locals {
  subnet_names_nsgs = zipmap(var.subnet_names, var.subnet_nsgs )
}

//plug imto local if no arguments and then use it from there
locals {
    nsgrules = var.nsgrules
}