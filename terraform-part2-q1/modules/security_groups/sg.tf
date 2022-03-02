variable "description" { }
variable "egress" {
    description = "Configuration block for egress rules"
}
variable "ingress" {
    description = "Configuration block for ingress rules"
}
variable "name_prefix" {
    description = "Creates a unique name beginning with the specified prefix. Conflicts with name. Forces new resource"
    default = null
}
variable "name" {
    description = "Name of the security group. If omitted, Terraform will assign a random, unique name. Forces new resource"
}
variable "revoke_rules_on_delete" {
    description = "Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself"
    default = false
}
variable "tags" {
    description = "Tags for this SG"
}
variable "vpc_id" {
    description = "VpcID of this SG"
}

resource "aws_security_group" "sg" {
    description               = var.description
    dynamic "egress" {
        for_each = var.egress
        content {
            from_port                 = lookup(egress.value, "from_port")
            to_port                   = lookup(egress.value, "to_port")
            cidr_blocks               = lookup(egress.value, "cidr_blocks", null)
            description               = lookup(egress.value, "description", null)
            ipv6_cidr_blocks          = lookup(egress.value, "ipv6_cidr_block", null)
            prefix_list_ids           = lookup(egress.value, "prefix_list_ids", null)
            protocol                  = lookup(egress.value, "protocol", null)
            security_groups           = lookup(egress.value, "security_groups", null)
            self                      = lookup(egress.value, "self", null)
        }
    }
    dynamic "ingress" {
        for_each = var.ingress
        content {
            from_port                 = lookup(ingress.value, "from_port")
            to_port                   = lookup(ingress.value, "to_port")
            cidr_blocks               = lookup(ingress.value, "cidr_blocks", null)
            description               = lookup(ingress.value, "description", null)
            ipv6_cidr_blocks          = lookup(ingress.value, "ipv6_cidr_block", null)
            prefix_list_ids           = lookup(ingress.value, "prefix_list_ids", null)
            protocol                  = lookup(ingress.value, "protocol", null)
            security_groups           = lookup(ingress.value, "security_groups", null)
            self                      = lookup(ingress.value, "self", null)
        }
    }
    name                              = var.name
    name_prefix                       = var.name_prefix
    revoke_rules_on_delete            = var.revoke_rules_on_delete
    tags                              = var.tags
    vpc_id                            = var.vpc_id
}

output "security_group_id" {
    value = aws_security_group.sg.id
}
output "security_group_arn" {
    value = aws_security_group.sg.arn
}
