variable "name" {
    description = "The user's name"
}
variable "path" {
    description = "Path to create user"
    default = "/"
}
variable "permissions_boundary" {
    description = "The ARN of the policy that is used to set the permissions boundary for the user"
    default = null
}
variable "force_destroy" {
    description = "Without this a user with non-Terraform-managed access keys and login profile will fail to be destroyed"
    default = false
}
variable "tags" {
    description = "Tags for the user"
    default = null
}

resource "aws_iam_user" "username" {
    name                 = var.name
    path                 = var.path
    permissions_boundary  = var.permissions_boundary
    force_destroy        = var.force_destroy
    tags                 = var.tags
}

output "iam_user_arn" {
    value = aws_iam_user.username.arn
}
output "iam_user_name" {
    value = aws_iam_user.username.name
}
output "iam_user_uniqueid" {
    value = aws_iam_user.username.unique_id
}