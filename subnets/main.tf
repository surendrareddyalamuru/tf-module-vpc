module "lm-subnets" {
  for_each = var.subnets
  cidr_block = each.value.cidr_block
  env = var.env
  source = "./lm-subnets"
  name = each.value.name
  vpc_id = var.vpc_id[0]
  subnet_availability_zones = var.subnet_availability_zones
  route_table_id = lookup(lookup(aws_route_table.aws_route-table, each.value.name, null), "id" , null)
}

#locals {
#  subnets_list = flatten([for i, j in module.lm-subnets : j.subnets])
#}
#
#output "subnetz-list" {
#  value = local.subnets_list[*].id
#}

resource "aws_route_table" "aws_route-table" {
  for_each = var.subnets
  vpc_id    = var.vpc_id[0]
  tags = {
    Name = "${var.env}-${each.value.name}-rt"
    ENV= var.env
    PROJECT = "roboshop"
  }
}

resource "aws_route" "peering_connection_route" {
  for_each = var.subnets
  route_table_id            = lookup(lookup(aws_route_table.aws_route-table, each.value.name, null), "id" , null)
  destination_cidr_block    = lookup(var.management_vpc, "vpc_cidr", null)
  vpc_peering_connection_id = var.peering_connection_id
}

output "subnets" {
  value = [for i, j in module.lm-subnets: concat(j.subnets)]
}