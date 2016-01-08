variable "name" {
  description = "Project name"
}

variable "environment" {
  default     = "development"
  description = "Environment (development, staging, production)"
}

variable "region" {
  default     = "us-east-1"
  description = "The AWS region to launch in"
}

variable "availability_zones" {
  default     = "us-east-1a,us-east-1c,us-east-1d"
  description = "The AWS availability zones to use"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR block"
}

variable "public_subnets" {
  default     = "10.0.0.0/20,10.0.64.0/20,10.0.128.0/20"
  description = "The public subnet CIDR blocks"
}

variable "private_subnets" {
  default     = "10.0.16.0/20,10.0.80.0/20,10.0.144.0/20"
  description = "The private subnet CIDR blocks"
}

variable "ephemeral_subnets" {
  default     = "10.0.32.0/20,10.0.96.0/20,10.0.160.0/20"
  description = "The ephemeral subnet CIDR blocks"
}

variable "bastion_ec2_key_name" {
  description = "The EC2 Key to use for the bastion server"
}
variable "bastion_ec2_key" {
  description = "The contents of the private key for connection to bastion"
}

variable "ec2_key_name" {
  description = "The EC2 Key to use for launching instances"
}
variable "ec2_key" {
  description = "The contents of the private EC2 key"
}
