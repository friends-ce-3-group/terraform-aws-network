# VPC settings
# ---------------------------------------------

variable "vpc_cidr" {
  type        = string
  description = "VPC cidr range"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Indicates whether instances with public IP addresses get corresponding public DNS hostnames"
  default     = false
}

variable "enable_dns_support" {
  type        = bool
  description = "Indicates whether the DNS resolution is supported"
  default     = false
}

variable "vpc_tags" {
  type        = map(string)
  description = "Add tags to the vpc"
  default     = {}
}

# Subnet settings
# ---------------------------------------------

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Use this for public subnets. Set to true to assign public IPs to the instances in the subnet."
  default     = false
}

variable "public_subnets" {
  # Syntax is object({ variable_name=type, ... }). e.g. object({ name=string, age=number })
  # See https://developer.hashicorp.com/terraform/language/expressions/type-constraints#object
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))

  default = {}
}

variable "tags_public_subnet" {
  type        = map(string)
  description = "Add tags to public subnets"
  default     = {}
}

variable "private_subnets" {
  # Syntax is object({ variable_name=type, ... }). e.g. object({ name=string, age=number })
  # See https://developer.hashicorp.com/terraform/language/expressions/type-constraints#object
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))

  default = {}
}

variable "tags_private_subnet" {
  type        = map(string)
  description = "Add tags to private subnets"
  default     = {}
}