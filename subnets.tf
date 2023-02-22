module "subnets" {
  for_each = var.vpc
  subnets = each.value.subnets
  source = "./subnets"
  vpc_id = [ for k, v in aws_vpc.main : v.id ]
  env = var.env
}