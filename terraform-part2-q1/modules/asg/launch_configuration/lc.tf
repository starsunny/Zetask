variable "name" {
    description = "name of the launch configuration"
}
variable "name_prefix" {
    description = "Creates a unique name beginning with the specified prefix. Conflicts with name"
    default = null
}
variable "image_id" {
    description = "EC2 Image ID to launch"
}
variable "instance_type" {
    description = "Size of instance to launch"
}
variable "iam_instance_profile" {
    description = "The name attribute of the IAM instance profile (IAM role) to associate with launched instances"
    default = null
}
variable "key_name" {
    description = "SSH key name to be used"
}
variable "security_groups" {
    description = "A list of associated security group IDS"
    default = []
}
variable "associate_public_ip_address" {
    description = "Associate a public ip address with an instance in a VPC"
    default = false
}
variable "user_data" {
    description = "The user data to provide when launching the instance"
    default = null
}
variable "placement_tenancy" {
    description = "The tenancy of the instance. Valid values are 'default' or 'dedicated'"
    default = "default"
}
variable "root_volume_type" {
    description = "Type of Root volume, gp2, gp3, io1 etc"
    default = "gp3"
}
variable "root_volume_size" {
    description = "Size of Root Volume"
    default = 20
}
variable "root_delete_on_termination" {
    description = "Root volume delete on termination"
    default = false
}
variable "root_encrypted" {
    description = "Encrypt root block device"
    default = true
}

resource "aws_launch_configuration" "lc" {
    name                                    = var.name
    image_id                                = var.image_id
    instance_type                           = var.instance_type
    iam_instance_profile                    = var.iam_instance_profile
    key_name                                = var.key_name
    security_groups                         = var.security_groups
    associate_public_ip_address             = var.associate_public_ip_address
    user_data                               = var.user_data
    placement_tenancy                       = var.placement_tenancy
    root_block_device {
        volume_type                         = var.root_volume_type
        volume_size                         = var.root_volume_size
        delete_on_termination               = var.root_delete_on_termination
        encrypted                           = var.root_encrypted
    }
    lifecycle {
        create_before_destroy               = true
    }
}

output "lc-id" { 
    value           = aws_launch_configuration.lc.id
}
output "lc-name" {
    value           = aws_launch_configuration.lc.name
}
output "lc-arn" {
    value           = aws_launch_configuration.lc.arn
}