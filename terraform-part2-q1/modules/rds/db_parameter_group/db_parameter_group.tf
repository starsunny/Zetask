
variable "name" {
    description = "Name for the parameter group"
}
variable "name_prefix" {
    description = "Creates a unique name beginning with the specified prefix"
    default = null
}
variable "family" {
    description = "The family of the DB parameter group"
}
variable "description" {
    description = "The description of the DB parameter group"
    default = "Parameter group for DB. Managed by Terraform"
}
variable "parameter" {
    description = " A list of DB parameters to apply"
    default = {}
}
variable "tags" {
    description = "Tags to apply to this resource"
    default = { }
}


resource "aws_db_parameter_group" "db_parameter_group" {
    name                   = var.name
    name_prefix            = var.name_prefix
    family                 = var.family
    description            = var.description
    tags                   = var.tags
    dynamic "parameter" {
        for_each = var.parameter
        content {
            name           = parameter.value.name
            value          = parameter.value.value
            apply_method   = parameter.value.apply_method
        }
    }
}

output "db_parameter_group_id" {
    value = aws_db_parameter_group.db_parameter_group.id
}
output "db_parameter_group_arn" {
    value = aws_db_parameter_group.db_parameter_group.arn
}
output "db_parameter_group_name" {
    value = aws_db_parameter_group.db_parameter_group.name
}