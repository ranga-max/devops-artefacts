# Variables are declared here

variable "region" {
  default = "eu-west-1"
}

variable "availability-zone" {
}

variable "owner-name" {
  default = "Terraform User"
}

variable "owner-email" {
  default = "test@test.io"
}

variable "dns-suffix" {
  default = "anything"
  description = "Suffix for DNS entry in Route 53. No spaces!"
}

variable "purpose" {
  default = "Ansible Lab"
}

variable "key-name" {
  default = "TF_KEY"
}

variable "ec2-count" {
}

variable "instance-type" {
  default = "t3a.large"
}

variable "hosted-zone-id" {
}

variable "aws-ami-id"  {
}

variable "linux-user" {
  default = "ubuntu" // ec2-user
}

variable "volume_size"  {
}

variable "node-name"  {
}

variable "subnet-type"  {
    default = "private"
}

variable "vpc_id"  {
}

variable "public_subnets_id"  {
    type = list(string)
    default = ["subnet1"]
}

variable "private_subnets_id"  {
    type = list(string)
    default = ["subnet1"]
}

variable "security_groups_ids"  {
}

