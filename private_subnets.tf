resource "aws_subnet" "subnets_private" {
    vpc_id = aws_vpc.vpc.id # this is required

    # Apply for all user input private subnets.
    # To understand the for_each syntax, see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
    for_each = var.private_subnets

    availability_zone = each.value.availability_zone # using the "value" of the map. the "value" is an a Terraform object with member variables availability_zone and cidr_block

    cidr_block = each.value.cidr_block

    map_public_ip_on_launch = false # instances in private subnet do not get public IPs

    tags = merge(
        {
            Name = each.key
        },
        var.tags_private_subnet
    )
}

# Each subnet has its own route table
resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.vpc.id

  for_each = aws_subnet.subnets_private
}

# Associate each subnet to a route table
resource "aws_route_table_association" "rt_assoc_private" {
    count = length(aws_subnet.subnets_private)

    subnet_id = element(aws_subnet.subnets_private.*.id, count.index)
    route_table_id = element(aws_route_table.rt_private.*.id, count.index)
}

resource "aws_route" "routes_to_nat_gateways" {
    count = length(aws_route_table.rt_private)

    route_table_id = element(aws_route_table.rt_private.*.id, count.index)

    destination_cidr_block = "0.0.0.0/0" # all comms to IPs outside of VPC cidr range goes to the IGW

    gateway_id = element(aws_nat_gateway.pvt_subnet_nats.*.id, count.index)
}