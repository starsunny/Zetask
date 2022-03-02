variable "group" {
    description = "Group name policy should be applied to"
}
variable "policy_arn" {
    description = "ARN of the policy you want to apply"
}

resource "aws_iam_group_policy_attachment" "group_policy_attchment" {
    group            = var.group
    policy_arn       = var.policy_arn
}
