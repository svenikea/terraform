resource "aws_vpc" "my_vpc" {
    count                   = var.vpc_cidr_block != null ? 1 : 0
    cidr_block              = var.vpc_cidr_block
    enable_dns_hostnames    = true
    enable_dns_support      = true
    instance_tenancy        = "default"
    tags = {
        Name                = "${var.project}-vpc"
        Terraform           = true
    }
}

resource "aws_vpc_endpoint" "vpc_endpoint" {
    for_each                = var.endpoint_service != null ? var.endpoint_service : {}
    vpc_id                  = var.vpc_cidr_block != null ? aws_vpc.my_vpc[0].id : null
    service_name            = "com.amazonaws.${var.region}.${each.key}"
    policy                  = lookup(each.value, "policy", local.default_vpc_policy)
    security_group_ids      = each.key == "s3" || each.key == "dynamodb" ? null : ["${aws_security_group.allow_vpce[each.key].id}"]
    subnet_ids              = each.key == "s3" || each.key == "dynamodb" ? null : aws_subnet.private_subnet.*.id
    vpc_endpoint_type       = each.key == "s3" || each.key == "dynamodb" ? "Gateway" : "Interface"
    private_dns_enabled     = each.key == "s3" || each.key == "dynamodb" ? false : lookup(each.value, "dns_enabled", null)
    route_table_ids         = each.key == "s3" || each.key == "dynamodb" ? aws_route_table.private_route.*.id : null
    tags = {
        Name                = "${var.project}-${upper("${each.key}")}-Endpoint"
        Terraform           = true
    }
}

resource "aws_security_group" "allow_vpce" {
    for_each                = var.endpoint_service != null ? var.endpoint_service : {}
    name                    = "${var.project}-${upper("${each.key}")}-Endpoint"
    description             = "${var.project}-${upper("${each.key}")}-Endpoint"
    vpc_id                  = aws_vpc.my_vpc[0].id

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["${var.vpc_cidr_block}"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name                = "${var.project}-${upper("${each.key}")}-sg"
        Terraform           = true
    }
}