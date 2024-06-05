provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source                  = "./modules/vpc"
  vpc_cidr_block          = "10.0.0.0/16"
  public_subnet_cidr_block = "10.0.1.0/24"
}

module "ecr" {
  source         = "./modules/ecr"
  repository_name = "my-website"
}

module "ecs" {
  source          = "./modules/ecs"
  cluster_name     = "my-website-cluster"
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = [module.vpc.public_subnet_id]
  container_name   = "my-website"
  container_image  = module.ecr.repository_url
}

module "alb" {
  source           = "./modules/alb"
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = [module.vpc.public_subnet_id]
  target_group_arn = module.ecs.target_group_arn
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}