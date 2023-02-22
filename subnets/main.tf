module "lm-subnets" {
  for_each = var.subnets
  cidr_block = each.value.cidr_block
  env = var.env
  source = "./lm-subnets"
  name = each.value.name
  vpc_id = var.vpc_id[0]
}