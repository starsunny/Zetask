variable "name" {
    description = "The name of the option group. Must be lowercase"
    default = null
}
variable "name_prefix" {
    description = "Creates new name starts with specified prefix"
    default = null
}
variable "option_group_description" {
    description = "The description of the option group"
    default = "Option group for DB. Managed by Terraform"
}
variable "engine_name" {
    description = "Specifies the name of the engine that this option group should be associated with"
}
variable "major_engine_version" {
    description = "Specifies the major version of the engine that this option group should be associated with"
}
variable "option" {
    description = "List of options to apply"
    default = { }
}
variable "tags" {
    description = "A map of tags to assign to the resource"
    default = { }
}


resource "aws_db_option_group" "db_option_group" {
    name                      = var.name
    name_prefix               = var.name_prefix
    option_group_description  = var.option_group_description
    engine_name               = var.engine_name
    major_engine_version      = var.major_engine_version
    tags                      = var.tags
    dynamic "option" {
        for_each = var.option
        content {
            option_name                       = lookup(option.value, "option_name")
            port                              = lookup(option.value, "port")
            version                           = lookup(option.value, "version")
            db_security_group_memberships     = lookup(option.value, "db_security_group_memberships")
            vpc_security_group_memberships    = lookup(option.value, "vpc_security_group_memberships")
            dynamic "option_settings" {
                for_each = lookup(option.value, "option_settings")
                content {
                    name                      = option_settings.value.name
                    value                     = option_settings.value.value
                }
            }
        }
    }
}

output "db_option_group_id" {
    value = aws_db_option_group.db_option_group.id
}
output "db_option_group_arn" {
    value = aws_db_option_group.db_option_group.arn
}
output "db_option_group_name" {
    value = aws_db_option_group.db_option_group.name
}