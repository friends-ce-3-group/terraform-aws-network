resource "aws_subnet" "subnets_public" {
    vpc_id = aws_vpc.vpc.id # this is required

    # Apply for all user input public subnets.
    # To understand the for_each syntax, see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
    for_each = var.public_subnets

    availability_zone = each.value.availability_zone # using the "value" of the map. the "value" is an a Terraform object with member variables availability_zone and cidr_block

    cidr_block = each.value.cidr_block

    map_public_ip_on_launch = var.map_public_ip_on_launch

    tags = var.tags_public_subnet
}