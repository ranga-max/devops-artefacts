provider "aws" {
  region     = var.region

  default_tags {
    tags = {
      owner_name = var.owner-name
      owner_email = var.owner-email
      purpose = var.purpose
    }
  }
}

// Resources further
//The count meta-argument accepts a whole number, and creates that many instances of the resource or module
//Terraform is providing you with a wildcard (*) also known as the splat expression [2] so you can fetch all the elements of a list instead of using the index to get one by one.
//Basically, the splat expression is just a short version of a for loop which you would have to use otherwise to get all the elements of a list. 
//The .id part fetches the ID attribute of a subnet. You could do the same for any other attribute of that resource. So in short: the splat expression helps you get all the .id attributes from all the private subne//ts which were created using the count meta-argument. 
resource "aws_instance" "brokers" {
  count         = var.broker-count
  ami           = var.aws-ami-id
  instance_type = var.broker-instance-type
  availability_zone = var.availability-zone[count.index % length(var.availability-zone)]

    # security_groups = ["${var.security_group}"]
  key_name = var.key-name

  root_block_device {
    volume_size = var.high_volume_size
    delete_on_termination = "true"
  }

  tags = {
    Name = "${var.owner-name}-broker-${count.index}"
    description = "broker nodes - Managed by Terraform"
    brokerid = count.index
    role = "broker"
    sshUser = var.linux-user
    Schedule = "kafka-mon-8am-fri-6pm"
    region = var.region
    role_region = "brokers-${var.region}"
  }

  subnet_id = var.subnet-id[count.index % length(var.subnet-id)]
  vpc_security_group_ids = var.vpc-security-group-ids
  associate_public_ip_address = false
}

resource "aws_route53_record" "zookeepers" {
  count = var.zk-count
  allow_overwrite = true
  zone_id = var.hosted-zone-id
  name = "zookeeper-${count.index}.${var.dns-suffix}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.brokers.*.private_ip, count.index)}"] 
  #records = ["${element(aws_instance.zookeepers.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "brokers" {
  count = var.broker-count
  allow_overwrite = true
  zone_id = var.hosted-zone-id
  name = "kafka-${count.index}.${var.dns-suffix}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.brokers.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "connect-cluster" {
  count = var.connect-count
  allow_overwrite = true
  zone_id = var.hosted-zone-id
  name = "connect-${count.index}.${var.dns-suffix}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.brokers.*.private_ip, count.index)}"]
  #records = ["${element(aws_instance.connect-cluster.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "schema" {
  count = var.schema-count
  allow_overwrite = true
  zone_id = var.hosted-zone-id
  name = "schema-${count.index}.${var.dns-suffix}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.brokers.*.private_ip, count.index)}"] 
  #records = ["${element(aws_instance.schema.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "control-center" {
  count = var.c3-count
  allow_overwrite = true
  zone_id = var.hosted-zone-id
  name = "controlcenter-${count.index}.${var.dns-suffix}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.brokers.*.private_ip, count.index)}"]
  #records = ["${element(aws_instance.control-center.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "rest" {
  count = var.rest-count
  allow_overwrite = true
  zone_id = var.hosted-zone-id
  name = "rest-${count.index}.${var.dns-suffix}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.brokers.*.private_ip, count.index)}"]
  #records = ["${element(aws_instance.rest.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "ksql" {
  count = var.ksql-count
  allow_overwrite = true
  zone_id = var.hosted-zone-id
  name = "ksql-${count.index}.${var.dns-suffix}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.brokers.*.private_ip, count.index)}"]
  #records = ["${element(aws_instance.ksql.*.private_ip, count.index)}"]
}

//resource "aws_eip" "eip_addr" {
//  count         = var.c3-count
//  instance   = aws_instance.control-center.*.id[count.index]
//  vpc = true
//}
