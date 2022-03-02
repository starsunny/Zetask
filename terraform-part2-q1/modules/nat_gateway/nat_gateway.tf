variable "allocation_id" {
    description = "The Allocation ID of the EIP address for the gateway. Required for connectivity_type of public"
}
variable "connectivity_type" {
    description = "Connectivity type for the gateway. Valid values are private and public"
    default = "public"
}
variable "subnet_id" {
    description = "(Req) Subnet ID in which to place the gateway"
}
variable "tags" {
    description = "tags for Nat Gateway"
}

resource "aws_nat_gateway" "nat_gateway" {
    allocation_id           = var.allocation_id
    connectivity_type       = var.connectivity_type
    subnet_id               = var.subnet_id
    tags                    = var.tags
}

output "nat_gateway_public_ip" {
    value = aws_nat_gateway.nat_gateway.public_ip
}
output "nat_gateway_allocation_id" {
    value = aws_nat_gateway.nat_gateway.allocation_id
}
output "nat_gateway_private_ip" {
    value = aws_nat_gateway.nat_gateway.private_ip
}
output "nat_gateway_id" {
    value = aws_nat_gateway.nat_gateway.id
}
output "nat_gateway_subnet_id" {
    value = aws_nat_gateway.nat_gateway.subnet_id
}