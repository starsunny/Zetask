variable "from_port" {
    description = "(Req) start port"
}
variable "protocol" {
    description = "(Req) Protocol used. If not icmp, icmpv6, tcp, udp, or all use the protocol number"
}
variable "security_group_id" {
    description = "(Req) Security group to apply this rule to."
}
variable "to_port" {
    description = "(Req) End port"
}
variable "type" {
    description = "Type of rule being created. ingress or egress"
}
variable "cidr_blocks" {
    description = "List of CIDR blocks"
    default = null
}
variable "description" {
    description = "Description of the rule"
    default = null
}
variable "ipv6_cidr_blocks" {
    description = "List of ipv6 cidr blocks"
    default = null
}
variable "prefix_list_ids" {
    description = "List of prefix list ids"
    default = null
}
variable "self" {
    description = "value"
    default = null
}

resource "aws_security_group_rule" "sg_rule" {
    from_port                    = var.from_port
    protocol                     = var.protocol
    security_group_id            = var.security_group_id
    to_port                      = var.to_port
    type                         = var.type
    cidr_blocks                  = var.cidr_blocks
    description                  = var.description
    ipv6_cidr_blocks             = var.ipv6_cidr_blocks
    prefix_list_ids              = var.prefix_list_ids
    self                         = var.self
}

output "security_group_id" {
    value                        = aws_security_group_rule.sg_rule.id
}