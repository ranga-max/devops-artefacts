resource "random_id" "random_id_prefix" {
  byte_length = 2
}

locals {
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}

module "Networking" {
  source               = "./modules/Networking"
  region               = var.region
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = local.availability_zones
}

module "Compute" {
  source         = "./modules/Compute"
  aws-ami-id     = var.aws-ami-id
  instance-type  = var.zk-instance-type
  key-name       = var.key-name
  volume_size    = var.volume_size
  node-name      = "ccloudpublic"
  subnet-type    = "public"
  owner-name     = var.owner-name
  linux-user     = var.linux-user
  ec2-count      = var.zk-count
  dns-suffix     = var.dns-suffix
  hosted-zone-id = var.hosted-zone-id
  availability-zone = "us-east-1"
  public_subnets_id = module.Networking.public_subnets_id[0]
  private_subnets_id = module.Networking.private_subnets_id[0]
  vpc_id = module.Networking.vpc_id
  security_groups_ids = module.Networking.security_groups_ids
}


