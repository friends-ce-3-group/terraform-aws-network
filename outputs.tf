output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "subnets_private" {
    value = aws_subnet.subnets_private
}

output "subnets_public" {
    value = aws_subnet.subnets_public
}

output "route_tables_private" {
    value = aws_route_table.rt_private
}

output "route_tables_public" {
    value = aws_route_table.rt_public
}

output "internet_gateway" {
    value = aws_internet_gateway.internet_gw
}

output "nat_gateways" {
    value = aws_nat_gateway.pvt_subnet_nats
}

