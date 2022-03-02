variable "cidr_block" { 
    description = "(Req) The CIDR block for the VPC"  
}
variable "instance_tenancy" {
    description = "A tenancy option for instances launched into the VPC. Default is 'default. options (dedicated or host)"
    default = "default" 
}
variable "enable_dns_support" {
    description = "A boolean flag to enable/disable DNS support in the VPC. Defaults true"
    default = true
}
variable "enable_dns_hostnames" {
    description = "A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
    default = true
}
variable "enable_classiclink" {
    description = "A boolean flag to enable/disable ClassicLink for the VPC"
    default =  false
}
variable "enable_classiclink_dns_support" {
    description = "A boolean flag to enable/disable ClassicLink DNS Support for the VPC"
    default = false
}
variable "assign_generated_ipv6_cidr_block" {
    description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC"
    default = false
}
variable "tags" {
    description = "Tags for the resource"
}

resource "aws_vpc" "vpc" {
    cidr_block                         = var.cidr_block
    instance_tenancy                   = var.instance_tenancy
    enable_dns_support                 = var.enable_dns_support
    enable_dns_hostnames               = var.enable_dns_hostnames
    enable_classiclink                 = var.enable_classiclink
    enable_classiclink_dns_support     = var.enable_classiclink_dns_support
    assign_generated_ipv6_cidr_block   = var.assign_generated_ipv6_cidr_block
    tags                               = var.tags
}

output "vpc_id" {
    value = aws_vpc.vpc.id
}
output "vpc_arn" {
    value = aws_vpc.vpc.arn
}
output "vpc_enable_dns_support" {
    value = aws_vpc.vpc.enable_dns_support
}
output "vpc_cidr_block" {
    value = aws_vpc.vpc.cidr_block 
}
output "vpc_main_route_table_id" {
    value = aws_vpc.vpc.main_route_table_id 
}
output "vpc_default_security_group_id" {
    value = aws_vpc.vpc.default_security_group_id 
}
