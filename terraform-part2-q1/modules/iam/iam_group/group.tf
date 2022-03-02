variable "name" {
    description = "Group name"
}
variable "path" {
    description = "Path in which to create a group"
    default = "/"
}

resource "aws_iam_group" "iam_group" {
    name      = var.name
    path      = var.path
}

output "iam_group_id" {
    value = aws_iam_group.iam_group.id
}
output "iam_group_arn" {
    value = aws_iam_group.iam_group.arn
}
output "iam_group_name" {
    value = aws_iam_group.iam_group.name
}
output "iam_group_uniqueid" {
    value = aws_iam_group.iam_group.unique_id
}