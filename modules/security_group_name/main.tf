resource "aws_security_group" "security_group_name" {
    vpc_id          = var.vpc_id
    name            = "${var.project}-${var.sg_name}-${var.env}"
    description     = var.sg_name

    tags = {
        Name        = "${var.project}-${var.sg_name}"
        Env         = var.env
        terraform   = true
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
}