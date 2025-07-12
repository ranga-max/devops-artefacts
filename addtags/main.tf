# Configure the AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure AWS Provider
provider "aws" {
  region = "us-east-1"  # Change to your desired region
}


# Using variables and for_each for multiple tags
#resource "aws_ec2_tag" "common_tags" {
#  for_each    = var.common_tags
#  resource_id = var.instance_id
#  key         = each.key
#  value       = each.value
#}

locals {
  # Create a flat list of all resource-tag combinations
  resource_tag_combinations = flatten([
    for resource_id in var.resource_ids : [
      for tag_key, tag_value in var.common_tags : {
        resource_id = resource_id
        key         = tag_key
        value       = tag_value
        identifier  = "${resource_id}-${tag_key}"
      }
    ]
  ])
}

resource "aws_ec2_tag" "common_tags_with_count" {
  count = length(local.resource_tag_combinations)

  resource_id = local.resource_tag_combinations[count.index].resource_id
  key         = local.resource_tag_combinations[count.index].key
  value       = local.resource_tag_combinations[count.index].value
}
