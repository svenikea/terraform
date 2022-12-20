resource "aws_subnet" "public_subnet" {
    vpc_id                      = aws_vpc.my_vpc[0].id
    count                       = var.public_subnets != null ? length(var.public_subnets) : 0
    cidr_block                  = var.public_subnets[count.index]
    map_public_ip_on_launch     = true
    availability_zone           = data.aws_availability_zones.filtered_zones.names[count.index]
    tags = {
        Name                    = "${var.project}-public-subnet-${count.index+1}"
        Terraform               = true
        Tier                    = "Public"
    }
}

resource "aws_route_table" "public_route" {
    vpc_id                      = aws_vpc.my_vpc[0].id
    dynamic "route" {
        for_each                = var.public_routes != null ? var.public_routes : []
        content {
            cidr_block          = route.value.cidr_block
            gateway_id          = route.value.gateway_id
        }
    }
    tags = {
        Name                    = "${var.project}-public-route"
        Terraform               = true
    }
    depends_on                  = [aws_subnet.public_subnet]
}

resource "aws_route_table_association" "associate_public_subnet" {
    count                       = var.public_subnets != null ? length(var.public_subnets) : 0
    subnet_id                   = aws_subnet.public_subnet.*.id[count.index]
    route_table_id              = aws_route_table.public_route.id
    depends_on                  = [
        aws_subnet.public_subnet
    ]
}
