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

  vpc_id       = "${module.vpc.vpc_id}"
  subnet_ids   = "${module.public_subnets.subnet_ids}"
  ec2_key_name = "${var.bastion_ec2_key_name}"
  private_key  = "${var.bastion_ec2_key}"
}

module "nat_gateway" {
  source = "github.com/pk4media/terraform.aws_nat_gateway"

  name        = "${var.name}-nat"
  environment = "${var.environment}"

  vpc_id         = "${module.vpc.vpc_id}"
  public_subnets = "${var.public_subnets}"
  subnet_ids     = "${module.public_subnets.subnet_ids}"
}

module "private_subnets" {
  source      = "github.com/pk4media/terraform.aws_private_subnet"

  name        = "${var.name}-private"
  environment = "${var.environment}"

  vpc_id      = "${module.vpc.vpc_id}"
  cidrs       = "${var.private_subnets}"
  availability_zones = "${var.availability_zones}"

  route_table_ids = "${module.nat_gateway.route_table_ids}"
}

module "ephemeral_subnets" {
  source      = "github.com/pk4media/terraform.aws_private_subnet"

  name        = "${var.name}-ephemeral"
  environment = "${var.environment}"

  vpc_id      = "${module.vpc.vpc_id}"
  cidrs       = "${var.ephemeral_subnets}"
  availability_zones = "${var.availability_zones}"

  route_table_ids = "${module.nat_gateway.route_table_ids}"
}
