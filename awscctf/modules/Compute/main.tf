// Resources

locals {
  pub_subnet_list = var.public_subnets_id
  pri_subnet_list = var.private_subnets_id
  subnet-type = "${var.subnet-type}"
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}

data "aws_subnets" "invpcpublic" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}

data "aws_subnets" "invpcprivate" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
}

data "aws_subnet" "public" {
  for_each = {for i, val in local.pub_subnet_list: i => val}
  id       = each.value
}

data "aws_subnet" "private" {
  for_each = {for i, val in local.pri_subnet_list: i => val}
  id       = each.value
}

resource "aws_instance" "ec2" {
  count         = var.ec2-count
  ami           = var.aws-ami-id
  instance_type = var.instance-type
  key_name = var.key-name

  root_block_device {
    volume_size = var.volume_size
  }

  tags = {
    Name = "${var.owner-name}-${var.node-name}-${count.index}"
    description = "${var.node-name} nodes - Managed by Terraform"
    role = "${var.node-name}"
    Schedule = "${var.node-name}-mon-7am-sat-7pm"
    sshUser = var.linux-user
    region = var.region
    role_region = "${var.node-name}s-${var.region}"
  }

  #subnet_id = local.subnet-type != "private" ? data.aws_subnets.invpcpublic.ids[count.index % length(data.aws_subnets.invpcpublic.ids)] : data.aws_subnets.invpcprivate.ids[count.index % length(data.aws_subnets.invpcprivate.ids)]
  subnet_id = local.subnet-type != "private" ? data.aws_subnet.public[count.index % length(data.aws_subnets.invpcpublic.ids)].id : data.aws_subnet.private[count.index % length(data.aws_subnets.invpcprivate.ids)].id
  availability_zone = local.subnet-type != "private" ? data.aws_subnet.public[count.index % length(data.aws_subnets.invpcpublic.ids)].availability_zone : data.aws_subnet.private[count.index % length(data.aws_subnets.invpcprivate.ids)].availability_zone
  vpc_security_group_ids = local.subnet-type != "private" ? [var.security_groups_ids[0]] : [var.security_groups_ids[1]]
  associate_public_ip_address = local.subnet-type != "private" ? true : false
}

resource "aws_route53_record" "route53" {
  count = var.ec2-count
  allow_overwrite = true
  zone_id = var.hosted-zone-id
  name = "${var.node-name}-${count.index}.${var.dns-suffix}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.ec2.*.private_ip, count.index)}"]
}




