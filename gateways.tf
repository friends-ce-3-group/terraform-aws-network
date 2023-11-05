resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.vpc.id
}

# each private subnet to have a nat gateway attached
resource "aws_nat_gateway" "pvt_subnet_nats" {
  for_each = aws_subnet.subnets_private

  subnet_id = element([for subnet in aws_subnet.subnets_public: subnet.id], 
              index([for subnet in aws_subnet.subnets_private:  subnet.id], each.value.id)) # put nat gateways in public subnet

  allocation_id = aws_eip.eip_for_nat[each.key].id

}

# every NAT needs an EIP
resource "aws_eip" "eip_for_nat" {
  for_each = aws_subnet.subnets_private

  domain = "vpc"
}