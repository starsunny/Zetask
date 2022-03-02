variable "vpc_id" {
    description = "VPC ID for Route table"
}
variable "route" {
    description = "List of routes"
}
variable "tags" {
    description = "Tags for the route table"
    default = null
}
variable "propagating_vgws" {
    description = "List of virtual gateways for propagation"
    default = null
}

resource "aws_route_table" "route_table" {
    vpc_id                                 = var.vpc_id
    dynamic "route" {
        for_each = var.route
        content {
            #first 3 args are for destinations. One must be specified
            cidr_block                     = route.value.cidr_block
            ipv6_cidr_block                = lookup(route.value, "ipv6_cidr_block", null)
            destination_prefix_list_id     = lookup(route.value, "destination_prefix_list_id", null)
            #other args are for target. One must be specified
            carrier_gateway_id             = lookup(route.value, "carrier_gateway_id", null)
            egress_only_gateway_id         = lookup(route.value, "egress_only_gateway_id", null)
            gateway_id                     = lookup(route.value, "gateway_id", null)
            instance_id                    = lookup(route.value, "instance_id", null)
            local_gateway_id               = lookup(route.value, "local_gateway_id", null)
            nat_gateway_id                 = lookup(route.value, "nat_gateway_id", null)
            network_interface_id           = lookup(route.value, "network_interface_id", null)
            transit_gateway_id             = lookup(route.value, "transit_gateway_id", null)
            vpc_endpoint_id                = lookup(route.value, "vpc_endpoint_id", null)
            vpc_peering_connection_id      = lookup(route.value, "vpc_peering_connection_id", null)
        }
    }
    tags                                   = var.tags
    propagating_vgws                       = var.propagating_vgws
}

output "route_table_id" {
    value = aws_route_table.route_table.id
}
output "route_table_arn" {
    value = aws_route_table.route_table.arn
}