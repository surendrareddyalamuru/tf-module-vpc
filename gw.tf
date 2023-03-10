resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-igw"
  }
}
#
resource "aws_eip" "ngw" {
  vpc      = true
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw.id
  subnet_id     = lookup(lookup(module.public_subnets, "public", null), "subnets", null)[0].id

  tags = {
    Name = "NAT Gw"
  }
}

#locals {
#  private_route_tables = flatten([for i, j in module.private_subnets : j.rt])
#  private_subnets_list = flatten([for i, j in module.private_subnets : j.subnets-list])
#  public_route_tables  = flatten([for i, j in module.public_subnets : j.rt])
#  public_subnets_list = flatten([for i, j in module.public_subnets : j.subnets-list])
#}
#
#resource "aws_route" "internet_gateway_route_to_public_subnets" {
#  count = length(local.public_route_tables)
#  route_table_id            = element(local.public_route_tables, count.index )
#  destination_cidr_block    = "0.0.0.0/0"
#  gateway_id = aws_internet_gateway.gw[0].id
#}
#
#resource "aws_route" "nat_gateway_route_to_private_subnets" {
#  count = length(local.private_route_tables)
#  route_table_id            = element(local.private_route_tables, count.index )
#  destination_cidr_block    = "0.0.0.0/0"
#  gateway_id = aws_nat_gateway.ngw[0].id
#}

#locals {
#  private_route_tables = flatten([for i, j in module.private_subnets : j.rt])
#}
#
#output "test" {
#  value = local.private_route_tables
#}