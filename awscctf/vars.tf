variable "region" {
  default = "us-east-1"
}

variable "environment" {
  description = "tfuser-aws-dev"
}

variable "vpc_cidr" {
  description = "CIDR block of the vpc"
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
  default     = ["10.0.1.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
  default     = ["10.0.10.0/24"]
}

variable "availability-zones" {
  type = list(string)
  default = ["us-east-1a"]
}

variable "owner-name" {
  default = "Terraform User"
}

variable "owner-email" {
  default = "test@test.io"
}

variable "dns-suffix" {
  default     = "anything"
  description = "Suffix for DNS entry in Route 53. No spaces!"
}

variable "purpose" {
  default = "Ansible Lab"
}

variable "key-name" {
  default = "TF_KEY"
}

variable "hosted-zone-id" {
}

variable "aws-ami-id" {
}

variable "linux-user" {
  default = "ubuntu" // ec2-user
}

variable "node-name" {
  default = "zookeeper"
}

variable "zk-count" {
}

variable "broker-count" {
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

variable "volume_size" {
  default = 8
}

variable "subnet-type" {
  default = "private"
}

variable "aws_account_id" {
  description = "The AWS Account ID (12 digits)"
  type        = string
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
