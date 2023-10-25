resource "aws_subnet" "subnets_public" {
  vpc_id = aws_vpc.vpc.id # this is required

  # Apply for all user input public subnets.
  # To understand the for_each syntax, see https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = var.public_subnets

  availability_zone = each.value.availability_zone # using the "value" of the map. the "value" is an a Terraform object with member variables availability_zone and cidr_block

  cidr_block = each.value.cidr_block

  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    {
      Name = each.key
    },
    var.tags_public_subnet
  )
}

# Each subnet has its own route table
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc.id

  for_each = aws_subnet.subnets_public
}

# Associate each subnet to a route table
resource "aws_route_table_association" "rt_assoc_public" {
  for_each = aws_subnet.subnets_public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt_public[each.key].id
}

# add a route for 0.0.0.0/0 to igw from the route table
resource "aws_route" "route_to_igw" {
  for_each = aws_route_table.rt_public

  route_table_id = each.value.id

  destination_cidr_block = "0.0.0.0/0" # all comms to IPs outside of VPC cidr range goes to the IGW

  gateway_id = aws_internet_gateway.internet_gw.id
}