resource "aws_security_group_rule" "cidr_ingress" {
    count                       = var.ipv4_cidr_blocks != null ? length(var.ipv4_cidr_blocks) : 0

    type                        = "ingress"
    from_port                   = var.port
    to_port                     = var.port
    cidr_blocks                 = ["${var.ipv4_cidr_blocks[count.index]}"]
    protocol                    = "tcp"
    security_group_id           = var.security_group_id

}

resource "aws_security_group_rule" "sg_id_ingress" {
    count                       = var.source_security_groups != null ? length(var.source_security_groups) : 0
     
    type                        = "ingress"
    from_port                   = var.port
    to_port                     = var.port
    protocol                    = "tcp"
    source_security_group_id    = var.source_security_groups[count.index]
    security_group_id           = var.security_group_id
}