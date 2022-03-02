variable "subnet_id" {
    description = "Subnet ID to create an association. Conflicts with gatewayID"
    default = null
}
variable "gateway_id" {
    description = "Gateway ID to create an association. Conflicts with subnetID"
    default = null
}
variable "route_table_id" {
    description = "(Req) ID of route table to associate with"
}

resource "aws_route_table_association" "rt_association" {
    subnet_id                   = var.subnet_id
    gateway_id                  = var.gateway_id
    route_table_id              = var.route_table_id
}

output "rt_association_id" {
    value = aws_route_table_association.rt_association.id
}