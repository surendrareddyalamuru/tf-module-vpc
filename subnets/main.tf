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

resource "aws_route_table" "aws_route-table" {
  for_each = var.subnets
  vpc_id    = var.vpc_id[0]
  tags = {
    Name = "${var.env}-${each.value.name}-rt"
    ENV= var.env
    PROJECT = "roboshop"
  }
}