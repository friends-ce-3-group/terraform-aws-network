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
  type        = map(string) # See 
  description = "Add tags to the vpc"
  default     = {}
}

