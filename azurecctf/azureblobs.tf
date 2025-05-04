locals {
   subnet_id = tolist(module.Networking.vnet_private_subnets)[0][0]
}

module "azure-blobs" {
  source = "./modules/azureblobs"
  rg_name      = var.rg_name
  subnet_id = local.subnet_id
  #count = var.enable_azure-blobs_module ? 1 : 0
  #depends_on = [module.Networking, module.Compute] 
}