variable "availability_zone" {
    description = "AZ for subnet"
    default = null
}
variable "availability_zone_id" {
    description = "AZ id for subnet"
    default = null
}
variable "cidr_block" {
    description = "CIDR block for subnet"
}
variable "customer_owned_ipv4_pool" {
    description =  "The customer owned IPv4 address pool"
    default = null
}
variable "ipv6_cidr_block" {
    description = "The IPv6 network range for the subnet, in CIDR notation"
    default = null
}
variable "map_customer_owned_ip_on_launch" {
    description = "Specify true to indicate that network interfaces created in the subnet should be assigned a customer owned IP address"
    default = null
}
variable "map_public_ip_on_launch" {
    description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address"
    default = null
}
variable "outpost_arn" {
    description = "The Amazon Resource Name (ARN) of the Outpost."
    default = null
}
variable "assign_ipv6_address_on_creation" {
    description = "Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address"
    default = null
}
variable "vpc_id" {
    description = "The VPC ID"
}
variable "tags" {
    description = "Tags for the subnet"
    default = null
}


resource "aws_subnet" "subnet" {
    availability_zone                     = var.availability_zone
    availability_zone_id                  = var.availability_zone_id
    cidr_block                            = var.cidr_block
    customer_owned_ipv4_pool              = var.customer_owned_ipv4_pool
    ipv6_cidr_block                       = var.ipv6_cidr_block
    map_customer_owned_ip_on_launch       = var.map_customer_owned_ip_on_launch
    map_public_ip_on_launch               = var.map_public_ip_on_launch
    outpost_arn                           = var.outpost_arn
    assign_ipv6_address_on_creation       = var.assign_ipv6_address_on_creation
    vpc_id                                = var.vpc_id
    tags                                  = var.tags
}

output "subnet_id" {
    value = aws_subnet.subnet.id 
}
output "subnet_arn" {
    value = aws_subnet.subnet.arn
}
output "subnet_az" {
    value = aws_subnet.subnet.availability_zone
}