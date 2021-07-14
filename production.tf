module "networking" {
source = "./modules/networking"
  region               = "${var.region}"
  environment          = "${var.environment}"
  vpc_cidr_block       = "${var.vpc_cidr_block}"
  subnet_newbits       = "${var.subnet_newbits}"
}
module "ecs_cluster" {
source = "./modules/ecs_cluster"
  environment          = "${var.environment}"
  name		       = "${var.name}"
}
#module "redis" {
#source = "./modules/redis"
#  environment          = "${var.environment}"
#  name                 = "${var.name}"
#  security_group       = module.networking.security_group_id
#  private_subnet       = module.networking.private_subnet_id
#}
#module "efs" {
#source = "./modules/efs"
#  environment          = "${var.environment}"
#  name                 = "${var.name}"
# security_group       = module.networking.security_group_id
#  private_subnet       = module.networking.private_subnet_id
#}
module "rds" {
source = "./modules/rds"
  environment                = var.environment
  name                       = var.name
  private_subnets             = module.networking.private_subnet_ids
  vpc_id                     = module.networking.vpc_id
  vpc_cidr_block             = var.vpc_cidr_block
  rds_instance_password      = var.rds_instance_password
  rds_mysql_version          = var.rds_mysql_version
  rds_instance_type          = var.rds_instance_type
  rds_min_storage            = var.rds_min_storage
  rds_max_allocated_storage  = var.rds_max_allocated_storage
  rds_enable_multi_az        = var.rds_enable_multi_az
  
}
module "loadbalancer" {
source = "./modules/loadbalancer"
  environment          = "${var.environment}"
  name                 = "${var.name}"
  vpc_id                     = module.networking.vpc_id
  public_subnets             = module.networking.public_subnet_ids
  security_group             = module.networking.security_group_id
  vpc_cidr_block             = var.vpc_cidr_block
}
