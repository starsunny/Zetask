variable "description" {
    description = "Description of the role"
    default = null
}
variable "force_detach_policies" {
    description = "Whether to force detaching any policies the role has before destroying it"
    default = false
}
variable "inline_policy" {
    description = "Configuration block defining an exclusive set of IAM inline policies associated with the IAM role"
    default = []
}
variable "managed_policy_arns" {
    description = "Set of exclusive IAM managed policy ARNs to attach to the IAM role"
    default = []
}
variable "max_session_duration" {
    description = "Maximum session duration (in seconds) that you want to set for the specified role"
    default = 3600
}
variable "name" {
    description = "name of the role"
}
variable "name_prefix" {
    description = "Creates a unique friendly name beginning with the specified prefix"
    default = null
}
variable "path" {
    description = "Path to the role"
    default = null
}
variable "permissions_boundary" {
    description = "ARN of the policy that is used to set the permissions boundary for the role."
    default = null
}
variable "tags" {
    description = "Tags for the role"
}
variable "assume_role_policy" {
    description = "Add assume role policy to the role"
}


resource "aws_iam_role" "role" {
    description                        = var.description
    force_detach_policies              = var.force_detach_policies
    assume_role_policy                 = var.assume_role_policy
    inline_policy {
      
    }
    dynamic "inline_policy" {
        for_each = var.inline_policy
        content {
            name                       = inline_policy.value.name
            policy                     = inline_policy.value.policy
        }
    }
    managed_policy_arns                = var.managed_policy_arns
    max_session_duration               = var.max_session_duration
    name                               = var.name
    name_prefix                        = var.name_prefix
    path                               = var.path
    permissions_boundary               = var.permissions_boundary
    tags                               = var.tags
}
resource "aws_iam_instance_profile" "instance-profile" {
    name                               = aws_iam_role.role.name
    role                               = aws_iam_role.role.name

}
output "arn" {
    value = aws_iam_role.role.arn
}
output "name" {
    value = aws_iam_role.role.name
}
output "id" {
    value = aws_iam_role.role.id
}