variable "topics" {
  type = map(object({
    partitions_count = number
    cleanup_policy   = string
  }))
}