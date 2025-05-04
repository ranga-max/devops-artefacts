# Variables are declared here

variable "region" {
  default = "eu-west-1"
}

variable "availability-zone" {
  type = list(string)
}

variable "owner-name" {
  default = "Sven Erik Knop"
}

variable "owner-email" {
  default = "sven@confluent.io"
}

variable "dns-suffix" {
  default = "changeme"
  description = "Suffix for DNS entry in Route 53. No spaces!"
}

variable "purpose" {
  default = "Bootcamp"
}

variable "key-name" {
  default = "sven-bootcamp"
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

variable "zk-dns-count" {
  default = 0
}

variable "broker-dns-count" {
  default = 0
}

variable "connect-dns-count" {
  default = 0
}

variable "schema-dns-count" {
  default = 0
}

variable "rest-dns-count" {
  default = 0
}

variable "c3-dns-count" {
  default = 0
}

variable "ksql-dns-count" {
  default = 0
}

variable "share_mode" {
  type        = bool
  description = "Set to true if sharing broker nodes with other components"
  nullable    = false
  default     = true 
}

variable "publicip_flag" {
  type        = bool
  description = "Set to true if publicip is not required"
  nullable    = false
  default     = false
}


variable "zk-instance-type" {
  default = "t3a.large"
}

variable "broker-instance-type" {
  default = "t3a.large"
}

variable "schema-instance-type" {
  default = "t3a.large"
}

variable "connect-instance-type" {
  default = "t3a.large"
}

variable "rest-instance-type" {
  default = "t3a.large"
}

variable "c3-instance-type" {
  default = "t3a.large"
}

variable "ksql-instance-type" {
  default = "t3a.large"
}

variable "client-instance-type" {
  default = "t3a.large"
}

variable "hosted-zone-id" {
}


variable "aws-ami-id"  {
}

variable "linux-user" {
  default = "ubuntu" // ec2-user
}

variable "vpc-id" {
}

variable "subnet-id" {
  type = list(string)
}

variable "vpc-security-group-ids" {
  type = list(string)
}
