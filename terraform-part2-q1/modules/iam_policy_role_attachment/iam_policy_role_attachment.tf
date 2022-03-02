variable "role" {
    description = "The name of the IAM role to which the policy should be applied"
}
variable "policy_arn" {
    description = "The ARN of the policy you want to apply"
}

resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
    role                         = var.role
    policy_arn                   = var.policy_arn
}