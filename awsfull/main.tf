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
resource "aws_instance" "zookeepers" {
  count         = var.zk-count
  ami           = var.aws-ami-id
  instance_type = var.zk-instance-type
  key_name = var.key-name

  root_block_device {
    volume_size = var.high_volume_size
    delete_on_termination = "true"
  }

  tags = {
    Name = "${var.owner-name}-zookeeper-${count.index}"
    description = "zookeeper nodes - Managed by Terraform"
    role = "zookeeper"
    zookeeperid = count.index
    Schedule = "zookeeper-mon-8am-fri-6pm"
    sshUser = var.linux-user
    region = var.region
    role_region = "zookeepers-${var.region}"
  }

  subnet_id = var.subnet-id[count.index % length(var.subnet-id)]
  availability_zone = var.availability-zone[count.index % length(var.availability-zone)]
  vpc_security_group_ids = var.vpc-security-group-ids
  associate_public_ip_address = false
}

//To manage several of the same resources, you can use either count or for_each, which removes the need to write a separate block of code for each one.
//count is sensible for any changes in list order, this means that if for some reason order of the list is changed, terraform will force replacement of all resources of which the index in the list has changed.
//element retrieves a single element from a list.
//

resource "aws_route53_record" "zookeepers" {
  count = var.zk-count
  allow_overwrite = true
  zone_id = var.hosted-zone-id
  name = "zookeeper-${count.index}.${var.dns-suffix}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.zookeepers.*.private_ip, count.index)}"]
}

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

resource "aws_route53_record" "brokers" {
  count = var.broker-count
  allow_overwrite = true
  zone_id = var.hosted-zone-id
  name = "kafka-${count.index}.${var.dns-suffix}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.brokers.*.private_ip, count.index)}"]
}

resource "aws_instance" "connect-cluster" {
  count         = var.connect-count
  ami           = var.aws-ami-id
  instance_type = var.connect-instance-type
  availability_zone = var.availability-zone[count.index % length(var.availability-zone)]
  key_name = var.key-name
  tags = {
    Name = "${var.owner-name}-connect-${count.index}"
    description = "Connect nodes - Managed by Terraform"
    role = "connect"
    Schedule = "mon-8am-fri-6pm"
    sshUser = var.linux-user
    region = var.region
    role_region = "connect-${var.region}"
  }

  root_block_device {
    volume_size = var.high_volume_size
    delete_on_termination = "true"
  }

  subnet_id = var.subnet-id[count.index % length(var.subnet-id)]
  vpc_security_group_ids = var.vpc-security-group-ids
  associate_public_ip_address = false
}

resource "aws_route53_record" "connect-cluster" {
  count = var.connect-count
  allow_overwrite = true
  zone_id = var.hosted-zone-id
  name = "connect-${count.index}.${var.dns-suffix}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.connect-cluster.*.private_ip, count.index)}"]
}

resource "aws_instance" "schema" {
  count         = var.schema-count
  ami           = var.aws-ami-id
  instance_type = var.schema-instance-type
  availability_zone = var.availability-zone[count.index % length(var.availability-zone)]
  key_name = var.key-name
  tags = {
    Name = "${var.owner-name}-schema-${count.index}"
    description = "Schema nodes - Managed by Terraform"
    role = "schema"
    Schedule = "mon-8am-fri-6pm"
    sshUser = var.linux-user
    region = var.region
    role_region = "schema-${var.region}"
  }

  root_block_device {
    volume_size = var.low_volume_size
    delete_on_termination = "true"
 }

  subnet_id = var.subnet-id[count.index % length(var.subnet-id)]
  vpc_security_group_ids = var.vpc-security-group-ids
  associate_public_ip_address = false
}

resource "aws_route53_record" "schema" {
  count = var.schema-count
  allow_overwrite = true
  zone_id = var.hosted-zone-id
  name = "schema-${count.index}.${var.dns-suffix}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.schema.*.private_ip, count.index)}"]
}

//resource "aws_instance" "control-center" {
//  count         = var.c3-count
//  ami           = var.aws-ami-id
//  instance_type = var.c3-instance-type
//  availability_zone = var.availability-zone[count.index % length(var.availability-zone)]
//  key_name = var.key-name

//  root_block_device {
//    volume_size = var.low_volume_size
//    delete_on_termination = "true"
//  }

//  tags = {
//    Name = "${var.owner-name}-control-center-${count.index}"
//    description = "Control Center nodes - Managed by Terraform"
//    role = "Control Center"
//    Schedule = "mon-8am-fri-6pm"
//    sshUser = var.linux-user
//    region = var.region
//    role_region = "schema-${var.region}"
//  }

//  subnet_id = var.subnet-id[count.index % length(var.subnet-id)]
//  vpc_security_group_ids = var.vpc-security-group-ids
//  associate_public_ip_address = false
//}

resource "aws_instance" "control-center" {
  for_each = var.c3-nodes
  ami           = var.aws-ami-id
  instance_type = var.c3-instance-type
  availability_zone = var.availability-zone[index(keys(var.c3-nodes),each.key) % length(var.availability-zone)]
  key_name = var.key-name

  root_block_device {
    volume_size = var.low_volume_size
    delete_on_termination = "true"
  }

  tags = {
    Name = "${var.owner-name}-${each.value}"
    description = "Control Center nodes - Managed by Terraform"
    role = "Control Center"
    Schedule = "mon-8am-fri-6pm"
    sshUser = var.linux-user
    region = var.region
    role_region = "control-center-${var.region}"
  }

  subnet_id = var.subnet-id[index(keys(var.c3-nodes),each.key) % length(var.subnet-id)]
  vpc_security_group_ids = var.vpc-security-group-ids
  associate_public_ip_address = false
}

//resource "aws_route53_record" "control-center" {
//  count = var.c3-count
//  allow_overwrite = true
//  zone_id = var.hosted-zone-id
//  name = "controlcenter-${count.index}.${var.dns-suffix}"
//  type = "A"
//  ttl = "300"
//  records = ["${element(aws_instance.control-center.*.private_ip, count.index)}"]
//}

resource "aws_route53_record" "control-center" {
    for_each = var.c3-nodes
//    locals {
//       pip = lookup(aws_instance.control-center[each.key], "private_ip", "")
//    } 
    allow_overwrite = true
    zone_id = var.hosted-zone-id
    name = "controlcenter-${index(keys(var.c3-nodes),each.key)}.${var.dns-suffix}"
    type = "A"
    ttl = "300"
    records = [lookup(aws_instance.control-center[each.key], "private_ip", "")]
//    records = ["${element(aws_instance.control-center.*.private_ip, index(keys(var.c3-nodes),each.key))}"]
}

resource "aws_instance" "rest" {
  count         = var.rest-count
  ami           = var.aws-ami-id
  instance_type = var.rest-instance-type
  availability_zone = var.availability-zone[count.index % length(var.availability-zone)]

  key_name = var.key-name

  root_block_device {
    volume_size = var.low_volume_size
    delete_on_termination = "true"
  }

  tags = {
    Name = "${var.owner-name}-rest-${count.index}"
    description = "Rest nodes - Managed by Terraform"
    role = "schema"
    Schedule = "mon-8am-fri-6pm"
    sshUser = var.linux-user
    region = var.region
    role_region = "schema-${var.region}"
  }

  subnet_id = var.subnet-id[count.index % length(var.subnet-id)]
  vpc_security_group_ids = var.vpc-security-group-ids
  associate_public_ip_address = false
}

resource "aws_route53_record" "rest" {
  count = var.rest-count
  allow_overwrite = true
  zone_id = var.hosted-zone-id
  name = "rest-${count.index}.${var.dns-suffix}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.rest.*.private_ip, count.index)}"]
}

resource "aws_instance" "ksql" {
  count         = var.ksql-count
  ami           = var.aws-ami-id
  instance_type = var.ksql-instance-type
  availability_zone = var.availability-zone[count.index % length(var.availability-zone)]
  key_name = var.key-name

  root_block_device {
    volume_size = var.high_volume_size
    delete_on_termination = "true"
  }

  tags = {
    Name = "${var.owner-name}-ksql-${count.index}"
    description = "Rest nodes - Managed by Terraform"
    role = "schema"
    Schedule = "mon-8am-fri-6pm"
    sshUser = var.linux-user
    region = var.region
    role_region = "schema-${var.region}"
  }

  subnet_id = var.subnet-id[count.index % length(var.subnet-id)]
  vpc_security_group_ids = var.vpc-security-group-ids
  associate_public_ip_address = false
}

resource "aws_route53_record" "ksql" {
  count = var.ksql-count
  allow_overwrite = true
  zone_id = var.hosted-zone-id
  name = "ksql-${count.index}.${var.dns-suffix}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.ksql.*.private_ip, count.index)}"]
}



//resource "aws_eip" "eip_addr" {
//  count         = var.c3-count
//  instance   = aws_instance.control-center.*.id[count.index]
//  vpc = true
//}
