resource "null_resource" "prevent_destroy_all" {
  lifecycle { 
    prevent_destroy = false
  }
}

data "confluent_environment" "env_confluentPS" {
  id = var.env_confluentPS_id
}

resource "confluent_network" "private-link" {
  display_name     = "rrchakpvtlnkmw"
  cloud            = "AWS"
  region           = var.region
  connection_types = ["PRIVATELINK"]
  zones            = keys(var.subnets_to_privatelink)
  environment {
    id = data.confluent_environment.env_confluentPS.id
  }
  dns_config {
    resolution = "PRIVATE"
  }
   lifecycle {
    prevent_destroy = false
  }
}

resource "confluent_private_link_access" "aws" {
  display_name = "rrchakpvtlnkaccess"
  aws {
    account = var.aws_account_id
  }
  environment {
    id = data.confluent_environment.env_confluentPS.id
  }
  network {
    id = confluent_network.private-link.id
  }
  lifecycle {
    prevent_destroy = false
  }
}


# https://docs.confluent.io/cloud/current/networking/private-links/aws-privatelink.html
# Set up Private Endpoints for Azure Private Link in your Azure subscription
# Set up DNS records to use Azure Private Endpoints

#locals {
#  hosted_zone = length(regexall(".glb", confluent_kafka_cluster.aws-dedicated-dev.bootstrap_endpoint)) > 0 ? replace(regex("^[^.]+-([0-9a-zA-Z]+[.].*):[0-9]+$", confluent_kafka_cluster.azure-dedicated-dev.rest_endpoint)[0], "glb.", "") : regex("[.]([0-9a-zA-Z]+[.].*):[0-9]+$", confluent_kafka_cluster.azure-dedicated-dev.bootstrap_endpoint)[0]
#  network_id  = regex("^([^.]+)[.].*", local.hosted_zone)[0]
#}

# https://docs.confluent.io/cloud/current/networking/private-links/aws-privatelink.html
# Set up the VPC Endpoint for AWS PrivateLink in your AWS account
# Set up DNS records to use AWS VPC endpoints

locals {
  dns_domain = confluent_network.private-link.dns_domain
}

#vpc_id will be sent when the module is called from the output of the networking module
data "aws_vpc" "privatelink" {
  id = var.vpc_id
}

data "aws_availability_zone" "privatelink" {
  for_each = var.subnets_to_privatelink
  zone_id  = each.key
}

locals {
  bootstrap_prefix = split(".", local.bootstrap_endpoint)[0]
}

resource "aws_security_group" "privatelink" {
  # Ensure that SG is unique, so that this module can be used multiple times within a single VPC
  name        = "ccloud-privatelink_${local.bootstrap_prefix}_${var.vpc_id}"
  #description = "Confluent Cloud Private Link minimal security group for ${confluent_kafka_cluster.dedicated.bootstrap_endpoint} in ${var.vpc_id}"
  description = "Confluent Cloud Private Link minimal security group for ${local.bootstrap_endpoint} in ${var.vpc_id}"
  vpc_id      = var.vpc_id

  ingress {
    # only necessary if redirect support from http/https is desired
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.privatelink.cidr_block]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.privatelink.cidr_block]
  }

  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.privatelink.cidr_block]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_endpoint" "privatelink" {
  vpc_id            = data.aws_vpc.privatelink.id
  service_name      = confluent_network.private-link.aws[0].private_link_endpoint_service
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.privatelink.id,
  ]

  subnet_ids          = [for zone, subnet_id in var.subnets_to_privatelink : subnet_id]
  private_dns_enabled = false

  depends_on = [
    confluent_private_link_access.aws,
  ]
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_route53_zone" "privatelink" {
  name = local.dns_domain

  vpc {
    vpc_id = data.aws_vpc.privatelink.id
  }
}

resource "aws_route53_record" "privatelink" {
  count   = length(var.subnets_to_privatelink) == 1 ? 0 : 1
  zone_id = aws_route53_zone.privatelink.zone_id
  name    = "*.${aws_route53_zone.privatelink.name}"
  type    = "CNAME"
  ttl     = "60"
  records = [
    aws_vpc_endpoint.privatelink.dns_entry[0]["dns_name"]
  ]
}

locals {
  endpoint_prefix = split(".", aws_vpc_endpoint.privatelink.dns_entry[0]["dns_name"])[0]
}

resource "aws_route53_record" "privatelink-zonal" {
  for_each = var.subnets_to_privatelink

  zone_id = aws_route53_zone.privatelink.zone_id
  name    = length(var.subnets_to_privatelink) == 1 ? "*" : "*.${each.key}"
  type    = "CNAME"
  ttl     = "60"
  records = [
    format("%s-%s%s",
      local.endpoint_prefix,
      data.aws_availability_zone.privatelink[each.key].name,
      replace(aws_vpc_endpoint.privatelink.dns_entry[0]["dns_name"], local.endpoint_prefix, "")
    )
  ]
}
