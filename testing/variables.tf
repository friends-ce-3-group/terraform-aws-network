variable "proj_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "region" {
  type = string
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "enable_dns_support" {
  type = bool
}

variable "map_public_ip_on_launch" {
  type = bool
}

variable "subnets_public" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "subnets_private" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "tags_public_subnet" {
    type = map(string)
}

variable "tags_private_subnet" {
    type = map(string)
}

variable "vpc_tags" {
    type = map(string)
}