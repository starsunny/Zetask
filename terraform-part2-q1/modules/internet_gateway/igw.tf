variable "vpc_id" {
    description = "(Req) VPC ID to create in"
}
variable "tags" {
    description = "Tags for igw"
}

resource "aws_internet_gateway" "igw" {
    vpc_id             = var.vpc_id
    tags               = var.tags
}

output "igw_id" {
    value = aws_internet_gateway.igw.id
}
output "igw_arn" {
    value = aws_internet_gateway.igw.arn
}
output "igw_vpc_id" {
    value = aws_internet_gateway.igw.vpc_id
}