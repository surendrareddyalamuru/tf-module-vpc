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
