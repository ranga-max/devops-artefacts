## For Service Accounts

variable "accounts" {
  type = map(object({
    description = string
  }))
}

variable "service_accounts" {
  type = map(object({
    display_name = string
    role_definitions = list(object({
      role_name   = string
      crn_pattern = string
    }))
  }))
}