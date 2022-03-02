variable "pgp_key" {
    description = "Either a base-64 encoded PGP public key, or a keybase username"
    default = null
}
variable "status" {
    description = "Access key status to apply"
    default = "Active"
}
variable "user" {
    description = "IAM user to associate with this access key"
}

resource "aws_iam_access_key" "access_key" {
    pgp_key        = var.pgp_key
    status         = var.status
    user           = var.user
}

output "access_key_id" {
    value = aws_iam_access_key.access_key.id
}