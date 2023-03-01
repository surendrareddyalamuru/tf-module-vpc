resource "aws_internet_gateway" "igw" {
  count = length(local.vpc_ids)
  vpc_id = element(local.vpc_ids, count.index)

  tags = {
    Name = "${var.env}-igw"
  }
}

resource "aws_eip" "ngw" {
  vpc      = true
}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.ngw.id
  subnet_id     = aws_subnet.example.id

  tags = {
    Name = "${var.env}-ngw"
  }
}