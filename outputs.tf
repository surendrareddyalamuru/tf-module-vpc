output "public_subnets" {
  value = module.public_subnets
}


output "private_subnets" {
  value = module.private_subnets
}

output "test" {
  value = flatten([for i, j in module.private_subnets : j.subnets-list])
}