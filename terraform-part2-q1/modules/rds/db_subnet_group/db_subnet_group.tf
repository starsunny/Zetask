variable "name" {
    description = "The name of the DB subnet group"
    default = null
}
variable "name_prefix" {
    description = "Creates a unique name beginning with the specified prefix"
    default = null
}
variable "description" {
    description = "The description of the DB subnet group"
    default = "Description for rds db subnet group"
}
variable "subnet_ids" {
    description = "A list of VPC subnet IDs"
    default = []
}
variable "tags" {
    description = "A map of tags to assign to the resource"
    default = {}
}

resource "aws_db_subnet_group" "db_subnet_group" {
    name           = var.name
    name_prefix    = var.name_prefix
    description    = var.description
    subnet_ids     = var.subnet_ids
    tags           = var.tags
}

output "db_subnet_group_id" {
    value = aws_db_subnet_group.db_subnet_group.id
}
output "db_subnet_group_arn" {
    value = aws_db_subnet_group.db_subnet_group.arn
}
output "db_subnet_group_name" {
    value = aws_db_subnet_group.db_subnet_group.name
}
