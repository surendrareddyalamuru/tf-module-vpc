locals {
  subnets_list = flatten([for i, j in module.lm-subnets : j.subnets])
}

output "subnets-list" {
  value = local.subnets_list[*].id
}

output "subnetss" {
  value = module.lm-subnets
}


output "rt" {
  value = [ for i, j in aws_route_table.aws_route-table : j.id ]
  #{
  #  for k, v in aws_route_table.aws_route-table : k => v.id
  #  }
}
