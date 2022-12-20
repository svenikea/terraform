resource "aws_network_acl" "my_public_acl" {
    depends_on              = [aws_subnet.public_subnet]
    vpc_id                  = aws_vpc.my_vpc[0].id
    subnet_ids              = aws_subnet.public_subnet.*.id
    dynamic "ingress" {
        for_each            = var.public_subnet_acl_ingress != null ? var.public_subnet_acl_ingress : local.default_acl
            content {
                protocol    = ingress.value.protocol
                rule_no     = ingress.value.rule_no
                action      = ingress.value.action
                cidr_block  = ingress.value.cidr_block
                from_port   = ingress.value.from_port
                to_port     = ingress.value.to_port
            }
    }
    
    dynamic "egress" {
        for_each            = var.public_subnet_acl_egress != null ? var.public_subnet_acl_egress : local.default_acl
        content {
                protocol    = egress.value.protocol
                rule_no     = egress.value.rule_no
                action      = egress.value.action
                cidr_block  = egress.value.cidr_block
                from_port   = egress.value.from_port
                to_port     = egress.value.to_port
        }
    }
    tags = {
        Name                = "${var.project}-public-acl"
        Terraform           = true
    }
}

resource "aws_network_acl" "my_private_acl" {
    vpc_id                  = aws_vpc.my_vpc[0].id
    subnet_ids              = aws_subnet.private_subnet.*.id
    depends_on              = [aws_subnet.private_subnet]
    dynamic "ingress" {
        for_each            = var.private_subnet_acl_ingress != null ? var.private_subnet_acl_ingress : local.default_acl
            content {
                protocol    = ingress.value.protocol
                rule_no     = ingress.value.rule_no
                action      = ingress.value.action
                cidr_block  = ingress.value.cidr_block
                from_port   = ingress.value.from_port
                to_port     = ingress.value.to_port
            }
    }

    dynamic "egress" {
        for_each            = var.private_subnet_acl_egress != null ? var.private_subnet_acl_egress : local.default_acl
            content {
                protocol    = egress.value.protocol
                rule_no     = egress.value.rule_no
                action      = egress.value.action
                cidr_block  = egress.value.cidr_block
                from_port   = egress.value.from_port
                to_port     = egress.value.to_port
            }
    }
    
    tags = {
        Name                = "${var.project}-private-acl"
        Terraform           = true
    }
}