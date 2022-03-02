variable "address" {
    description = "IP address from an EC2 BYOIP pool"
    default = null
}
variable "associate_with_private_ip" {
    description = "User-specified primary or secondary private IP address to associate with the Elastic IP address"
    default = null
}
variable "customer_owned_ipv4_pool" {
    description = "ID of a customer-owned address pool"
    default = null
}
variable "instance" {
    description = "EC2 instance ID"
    default = null
}
variable "network_border_group" {
    description = "Location from which the IP address is advertised"
    default = null
}
variable "network_interface" {
    description = "Network interface ID to associate with"
    default = null
}
variable "public_ipv4_pool" {
    description = "EC2 IPv4 address pool identifier or amazon"
    default = null
}
variable "tags" {
    description = "tags for eip"
}
variable "vpc" {
    description = "Boolean if the EIP is in a VPC or not"
    default = true
}

resource "aws_eip" "eip" {
    address                      = var.address
    associate_with_private_ip    = var.associate_with_private_ip
    customer_owned_ipv4_pool     = var.customer_owned_ipv4_pool
    instance                     = var.instance
    network_border_group         = var.network_border_group
    network_interface            = var.network_interface
    public_ipv4_pool             = var.public_ipv4_pool
    tags                         = var.tags
    vpc                          = var.vpc
}

output "eip_allocation_id" {
    value = aws_eip.eip.allocation_id
}
output "eip_association_id" {
    value = aws_eip.eip.association_id
}
output "eip_carrier_ip" {
    value = aws_eip.eip.carrier_ip
}
output "eip_id" {
    value = aws_eip.eip.id
}
output "eip_public_ip" {
    value = aws_eip.eip.public_ip
}
output "eip_private_ip" {
    value = aws_eip.eip.private_ip
}
