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
  for_each = aws_subnet.subnets_private # iterate using subnets_private

  vpc_id = aws_vpc.vpc.id
}

# Associate each subnet to a route table
resource "aws_route_table_association" "rt_assoc_private" {
  for_each = aws_subnet.subnets_private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt_private[each.key].id
}

resource "aws_route" "routes_to_nat_gateways" {
  for_each = aws_subnet.subnets_private

  route_table_id = aws_route_table.rt_private[each.key].id

  destination_cidr_block = "0.0.0.0/0" # all comms to IPs outside of VPC cidr range goes to the IGW

  gateway_id = aws_nat_gateway.pvt_subnet_nats[each.key].id
}