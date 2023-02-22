resource "aws_subnet" "main" {
  count = length(var.cidr_block)
  vpc_id = [ for k, v in aws_vpc.main : v.id ]
  cidr_block = element(var.cidr_block, count.index)
  tags = local.subnet_tags
}