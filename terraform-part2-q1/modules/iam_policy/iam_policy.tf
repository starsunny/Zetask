variable "description" {
    description = "Description of the IAM policy"
    default = null
}
variable "name" {
    description = "Name for the policy"
}
variable "name_prefix" {
    description = "Creates a unique name beginning with the specified prefix."
    default = null
}
variable "path" {
    description = "Path in which to create the policy"
    default = null
}
variable "policy" {
    description = "The policy document"
}
variable "tags" {
    description = "Tags for the policy"
}

resource "aws_iam_policy" "policy" {
    name                          = var.name
    path                          = var.path
    description                   = var.description
    policy                        = var.policy
    tags                          = var.tags
    name_prefix                   = var.name_prefix
}


output "arn" {
  value       = aws_iam_policy.policy.arn
}
output "name" {
  value       = aws_iam_policy.policy.name
}
output "policy" {
  value       = aws_iam_policy.policy.policy
}