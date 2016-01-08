module "vpc" {
  source      = "github.com/pk4media/terraform.aws_vpc"

  name        = "${var.name}-vpc"
  environment = "${var.environment}"

  cidr        = "${var.vpc_cidr}"
}

module "public_subnets" {
  source      = "github.com/pk4media/terraform.aws_public_subnet"

  name        = "${var.name}-public"
  environment = "${var.environment}"

  vpc_id      = "${module.vpc.vpc_id}"
  cidrs       = "${var.public_subnets}"
  availability_zones = "${var.availability_zones}"
}

module "bastion" {
  source       = "github.com/pk4media/terraform.aws_bastion"

  name         = "${var.name}-bastion"
  environment  = "${var.environment}"

  region       = "${var.region}"

  vpc_id       = "${module.vpc.id}"
  subnet_ids   = "${module.public_subnets.subnet_ids}"
  ec2_key_name = "${var.bastion_ec2_key_name}"
  private_key  = "${var.bastion_ec2_key}"
}

module "nat" {
  source       = "github.com/pk4media/terraform.aws_nat"

  name         = "${var.name}-nat"
  environment  = "${var.environment}"

  region       = "${var.region}"

  vpc_id       = "${module.vpc.vpc_id}"
  vpc_cidr     = "${module.vpc.vpc_cidr}"

  public_subnets = "${var.public_subnets}"
  subnet_ids     = "${module.public_subnets.subnet_ids}"

  ec2_key_name   = "${var.ec2_key_name}"
  private_key    = "${var.ec2_key}"

  bastion_host        = "${module.bastion.private_ip}"
  bastion_user        = "${module.bastion.user}"
  bastion_private_key = "${module.bastion.private_key}"
  bastion_security_group_id = "${module.bastion.security_group_id}"
}

module "private_subnets" {
  source      = "github.com/pk4media/terraform.aws_private_subnet"

  name        = "${var.name}-private"
  environment = "${var.environment}"

  vpc_id      = "${module.vpc.vpc_id}"
  cidrs       = "${var.private_subnets}"
  availability_zones = "${var.availability_zones}"

  route_table_ids = "${module.nat.route_table_ids}"
}

module "ephemeral_subnets" {
  source      = "github.com/pk4media/terraform.aws_private_subnet"

  name        = "${var.name}-ephemeral"
  environment = "${var.environment}"

  vpc_id      = "${module.vpc.vpc_id}"
  cidrs       = "${var.epehemeral_subnets}"
  availability_zones = "${var.availability_zones}"

  route_table_ids = "${module.nat.route_table_ids}"
}
