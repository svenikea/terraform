output "vpc_id" {
    value = aws_vpc.my_vpc[0].id
}

output "igw_id" {
    value = aws_internet_gateway.my_igw.id
}

output "private_subnets" {
    value = aws_subnet.private_subnet.*.id
}

output "public_subnets" {
    value = aws_subnet.public_subnet.*.id
}

output "nat_gateway_public_ip" {
    value = var.private_subnets != null && var.new_elastic_ip == true ? aws_nat_gateway.my_nat[0].id : null
}

output "public_route_table_name" {
    value = aws_route_table.public_route.*.tags.Name
}

output "private_route_table_name" {
    value = aws_route_table.private_route.*.tags.Name
}

output "public_route_table_id" {
    value = aws_route_table.public_route.*.id
}

output "private_route_table_id" {
    value = aws_route_table.private_route.*.id
}
