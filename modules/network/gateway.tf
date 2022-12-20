resource "aws_internet_gateway" "my_igw" {
    vpc_id                  = aws_vpc.my_vpc[0].id
    tags = {
        Name                = "${var.project}-igw"
        Terraform           = true
    }
}

resource "aws_eip" "nat_eip" {
  count                     = var.private_subnets != null && var.new_elastic_ip == true ? 1 : 0
  depends_on                = [
    aws_internet_gateway.my_igw,
    aws_subnet.private_subnet
  ]
  vpc                       = true
  tags = {
    Name                    = "${var.project}" 
    Terraform               = true
  }
}

resource "aws_nat_gateway" "my_nat" {
  connectivity_type       = "public"
  count                   = var.public_subnets != null && var.nat_gate != false ? 1 : 0
  subnet_id               = aws_subnet.public_subnet[0].id
  allocation_id           = aws_eip.nat_eip[0].id
  depends_on              = [aws_subnet.private_subnet]
  tags = {
    Name                  = "${var.project}-nat-gateway"
    Terraform             = true
  }
}