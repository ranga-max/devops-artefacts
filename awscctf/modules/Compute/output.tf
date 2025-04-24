// Output

output "ec2_private_dns" {
  value = [aws_instance.ec2.*.private_dns]
}

output "ec2_alternate_dns" {
  value = [aws_route53_record.route53.*.name]
}

# cluster data
output "cluster_data" {
  value = {
    "ssh_username" = var.linux-user
    "ssh_key" = var.key-name
  }
}
