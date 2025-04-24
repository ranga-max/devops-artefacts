# Variables are declared here

variable "region" {
  default = "us-east-1"
}

variable "availability-zone" {
  type = list(string)
}

variable "owner-name" {
  default = "Test User"
}

variable "owner-email" {
  default = "test@test.io"
}

variable "dns-suffix" {
  default = "changeme"
  description = "Suffix for DNS entry in Route 53. No spaces!"
}

variable "purpose" {
  default = "kafka cluster provisioning"
}

variable "key-name" {
  default = "myssh-key"
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


variable "high_volume_size" {
  default = 64
}

variable "low_volume_size" {
  default = 20
}

variable "c3-nodes" {
  type = map(string)
  default = {
    "node1" = "control-center-1"
  }
}
