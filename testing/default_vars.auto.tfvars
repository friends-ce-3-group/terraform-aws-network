proj_name = "friends-capstone-vpc"

vpc_cidr = "30.0.0.0/16"

region = "us-west-2"

enable_dns_hostnames = true

enable_dns_support = true

map_public_ip_on_launch = true

subnets_public = {
  us_west_2a_pub_subnet = {
    cidr_block        = "30.0.1.0/24"
    availability_zone = "us-west-2a"
  },
  us_west_2b_pub_subnet = {
    cidr_block        = "30.0.2.0/24"
    availability_zone = "us-west-2b"
  }
}

subnets_private = {
  us_west_2a_pvt_subnet = {
    cidr_block        = "30.0.3.0/24"
    availability_zone = "us-west-2a"
  }
  us_west_2b_pvt_subnet = {
    cidr_block        = "30.0.4.0/24"
    availability_zone = "us-west-2b"
  }
}

tags_public_subnet = {
    Name = "${var.proj_name}-public-SN",
    subnet = "public"
  }

tags_private_subnet = {
    Name = "${var.proj_name}-pvt-SN",
    subnet = "private"
  }

vpc_tags = {
    Name = "${var.proj_name}"
}