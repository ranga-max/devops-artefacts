// Output

output "zookeeper_private_dns" {
  value = [aws_instance.brokers.*.private_dns]
}

output "zookeeper_alternate_dns" {
  value = [aws_route53_record.zookeepers.*.name]
}

output "broker_private_dns" {
  value = [aws_instance.brokers.*.private_dns]
}

output "broker_alternate_dns" {
  value = [aws_route53_record.brokers.*.name]
}

output "schema_private_dns" {
  value = [aws_instance.brokers.*.private_dns]
}

output "schema_alternate_dns" {
  value = [aws_route53_record.schema.*.name]
}

output "control_center_private_dns" {
  value = [aws_instance.brokers.*.private_dns]
}

output "control_center_alternate_dns" {
  value = [aws_route53_record.control-center.*.name]
}

# cluster data
output "cluster_data" {
  value = {
    "ssh_username" = var.linux-user
    "ssh_key" = var.key-name
  }
}
