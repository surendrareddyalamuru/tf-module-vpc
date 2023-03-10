#module "lm-subnets" {
#  for_each = var.subnets
#  cidr_block = each.value.cidr_block
#  env = var.env
#  source = "./lm-subnets"
#  name = each.value.name
#  vpc_id = var.vpc_id[0]
#  subnet_availability_zones = var.subnet_availability_zones
#  route_table_id = lookup(lookup(aws_route_table.aws_route-table, each.value.name, null), "id" , null)
#}
#
#
#
#
#
#

#
#resource "aws_route" "peering_connection_route" {
#  for_each = var.subnets
#  route_table_id            = lookup(lookup(aws_route_table.aws_route-table, each.value.name, null), "id" , null)
#  destination_cidr_block    = lookup(var.management_vpc, "vpc_cidr", null)
#  vpc_peering_connection_id = var.peering_connection_id
#}

resource "aws_subnet" "main" {
  count = length(var.cidr_block)
  vpc_id = var.vpc_id
  cidr_block = element(var.cidr_block, count.index)
  tags = local.subnet_tags
  availability_zone = element(var.subnet_availability_zones, count.index)
}

resource "aws_route_table" "aws_route-table" {
  vpc_id    = var.vpc_id
  tags = {
    Name = "${var.env}-${var.name}-rt"
    ENV= var.env
    PROJECT = "roboshop"
  }
}


resource "aws_route_table_association" "aws_route_table_association" {
  count = length(aws_subnet.main)
  subnet_id      = element(aws_subnet.main.*.id, count.index)
  route_table_id = aws_route_table.aws_route-table.id
}

#output "subnets" {
#  value = aws_subnet.main
#}