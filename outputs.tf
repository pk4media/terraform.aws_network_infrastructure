output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_cidr" {
  value = "${module.vpc.vpc_cidr}"
}

output "public_subnet_ids" {
  value = "${module.public_subnets.subnet_ids}"
}
output "public_subnet_cidrs" {
  value = "${module.public_subnets.subnet_cidrs}"
}

output "private_subnet_ids" {
  value = "${module.private_subnets.subnet_ids}"
}
output "private_subnet_cidrs" {
  value = "${module.private_subnets.subnet_cidrs}"
}

output "ephemeral_subnet_ids" {
  value = "${module.ephemeral_subnets.subnet_ids}"
}
output "ephemeral_subnet_cidrs" {
  value = "${module.ephemeral_subnets.subnet_cidrs}"
}

output "bastion_host" {
  value = "${module.bastion.public_ip}"
}
output "bastion_user" {
  value = "${module.bastion.user}"
}
output "bastion_private_key" {
  value = "${module.bastion.private_key}"
}
output "bastion_security_group_id" {
  value = "${module.bastion.security_group_id}"
}
