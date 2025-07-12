variable "resource_ids" {
  description = "The ID of the resource to tag"
  type        = list(string)
}

variable "common_tags" {
  description = "Common tags to apply to the EC2 instance"
  type        = map(string)
  default = {
    managed_by   = "xxx"
    user_id   = "xxx"
    environment  = "dev"
  }
}
