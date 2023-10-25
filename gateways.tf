resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.vpc.id
}

# each private subnet to have a nat gateway attached
resource "aws_nat_gateway" "pvt_subnet_nats" {
  count = length(aws_subnet.subnets_private)

  subnet_id = element(aws_subnet.subnets_private.*.id, count.index)

  allocation_id = element(aws_eip.eip_for_nat.*.id, count.index)

  depends_on = [ aws_internet_gateway.internet_gw ]
}

# every NAT needs an EIP
resource "aws_eip" "eip_for_nat" {
  for_each = aws_subnet.subnets_private

  domain = "vpc"
}