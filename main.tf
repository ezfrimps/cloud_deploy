provider "aws" {
  region  = var.region
  profile = "default"
}

terraform {
  backend "s3" {
    bucket = "evansterraformstate"
    key    = "cloud_deploy/terraform.tfstate"
    region = "us-east-2"
  }
}

# local {
#   dev_availability_zones = ["us-east-1a", "us-east-1b"]
# }

# resource "aws_key_pair" "key" {
#   key_name = "dev_key"
#   public_key = file("../dev-key.pem")
# }

# module "network" {
#   source = "./modules/networking"
#   environment = "dev"
#   vpc_cidr = "10.0.0.0/16"
#   public_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
#   private_subnets_cidr = ["10.0.10.0/24", "10.0.20.0/24"]
#   region = var.region
#   availability_zones = local.dev_availability_zones
#   key_name = "dev_key"
# }

# module "rds" {
#   source            = "./modules/rds"
#   environment       = "dev"
#   allocated_storage = "10"
#   database_name     = var.dev_database_name
#   database_username = var.dev_database_username
#   database_password = var.dev_database_password
#   subnet_ids        = module.networking.private_subnets_id
#   vpc_id            = module.networking.vpc_id
#   instance_class    = "db.t2.micro"
# }

# module "ecs" {
#   source              = "./modules/ecs"
#   environment         = "dev"
#   vpc_id              = module.networking.vpc_id
#   availability_zones  = local.dev_availability_zones
#   repository_name     = "odoojobs/dev"
#   subnets_ids         = [module.networking.private_subnets_id]
#   public_subnet_ids   = [module.networking.public_subnets_id]
#   security_groups_ids = [
#     module.networking.security_groups_ids,
#     module.rds.db_access_sg_id
#   ]
#   database_endpoint   = module.rds.rds_address
#   database_name       = var.dev_database_name
#   database_username   = var.dev_database_username
#   database_password   = var.dev_database_password
#   secret_key_base     = var.dev_secret_key_base
# }