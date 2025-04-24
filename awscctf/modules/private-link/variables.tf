#variable "confluent_cloud_api_key" {
#  description = "Confluent Cloud API Key (also referred as Cloud API ID)"
#  type        = string
#}

#variable "confluent_cloud_api_secret" {
#  description = "Confluent Cloud API Secret"
#  type        = string
#  sensitive   = true
#}

#variable "env_entreprise_nprd_id" {
#  description = "Entreprise Non Prod Confluent Environment ID"
#  type        = string
#}

#variable "availability_zone" {
#  description = "Availability zone for the Confluent Cloud Kafka cluster"
#  type        = string
#}

variable "env_confluentPS_id" {
  description = "Entreprise Non Prod Confluent Environment ID"
  type        = string
}

variable "region" {
  description = "The region of your VNet"
  type        = string
}

variable "vpc_id" {
}

#Static Placeholder 
variable "subnets_to_privatelink" {
  description = "A map of Zone ID to Subnet ID (i.e.: {\"use1-az1\" = \"subnet-abcdef0123456789a\", ...})"
  type        = map(string)
  default = {
  "use1-az1" = "subnet-xxxxx",
  "use1-az2" = "subnet-xxxxx",
  "use1-az4" = "subnet-xxxxx"
}
}

variable "aws_account_id" {
  description = "The AWS Account ID (12 digits)"
  type        = string
}

variable "bootstrap_endpoint" {
  description = "bootstrap_endpoint"
  type        = string
}


