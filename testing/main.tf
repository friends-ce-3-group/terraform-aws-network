module "vpc_network" {
  # source = "git::https://github.com/friends-ce-3-group/terraform-aws-network.git?ref=v0.1.5"
  source = "../"

  vpc_cidr = var.vpc_cidr

  enable_dns_hostnames = var.enable_dns_hostnames

  enable_dns_support = var.enable_dns_support

  vpc_tags = {
    Name = "${var.proj_name}-vpc"
  }

  map_public_ip_on_launch = var.map_public_ip_on_launch

  public_subnets = var.subnets_public

  tags_public_subnet = {
    Name = "${var.proj_name}-public-SN"
  }

  private_subnets = var.subnets_private

  tags_private_subnet = {
    Name = "${var.proj_name}-pvt-SN"
  }
}


# terraform {

#   required_version = ">= 1.4.0"

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }

# provider "aws" {
#   region = "us-west-2"
# }

# module "test_network" {
#   source = "../"

#   vpc_cidr = "30.0.0.0/16"

#   enable_dns_hostnames = true

#   enable_dns_support = true

#   vpc_tags = {
#     Name = "my_vpc"
#   }

#   map_public_ip_on_launch = true

#   public_subnets = {
#     us_west_2a_pub_subnet = {
#       cidr_block        = "30.0.1.0/24"
#       availability_zone = "us-west-2a"
#     }
#     us_west_2b_pub_subnet = {
#       cidr_block        = "30.0.2.0/24"
#       availability_zone = "us-west-2b"
#     }
#   }

#   tags_public_subnet = {
#     Name = "public subnets"
#   }

#   private_subnets = {
#     us_west_2a_pvt_subnet = {
#       cidr_block        = "30.0.3.0/24"
#       availability_zone = "us-west-2a"
#     }
#     us_west_2b_pvt_subnet = {
#       cidr_block        = "30.0.4.0/24"
#       availability_zone = "us-west-2b"
#     }
#   }

#   tags_private_subnet = {
#     Name = "private subnets"
#   }
# }