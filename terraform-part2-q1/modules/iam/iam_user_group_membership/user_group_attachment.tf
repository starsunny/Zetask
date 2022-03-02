variable "user" {
    description = "Name of IAM user to add to groups"
}
variable "groups" {
    description = "List of IAM groups to add user to"
}

resource "aws_iam_user_group_membership" "name" {
    user          = var.user
    groups        = var.groups
}
