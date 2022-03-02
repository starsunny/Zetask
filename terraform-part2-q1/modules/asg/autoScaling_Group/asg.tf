variable "name" {
    description = "The name of the Auto Scaling Group."  
}
variable "name_prefix" {
    description = "Creates a unique name beginning with the specified prefix" 
    default = null
}
variable "max_size" {
    description = "The maximum size of the Auto Scaling Group."
    default = 0
}
variable "min_size" {
    description = "The minimum size of the Auto Scaling Group."
    default = 0
}
variable "desired_capacity" {
    description = "The number of Amazon EC2 instances that should be running in the group"
    default = 0
}
variable "default_cooldown" {
    description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
    default = 300
}
variable "health_check_grace_period" {
    description = "Time (in seconds) after instance comes into service before checking health"
    default = 0
}
variable "health_check_type" {
    description = "EC2 or ELB Controls how health checking is done"
    default = "EC2"
}
variable "launch_configuration" {
    description = "The name of the launch configuration to use"
}
variable "load_balancers" {
    description = "A list of elastic load balancer names to add to the autoscaling group names"
    default = []
}
variable "target_group_arns" {
    description = "A set of aws_alb_target_group ARNs, for use with Application or Network Load Balancing"
    default = []
}
variable "subnets" {
    description = "List of subnets to launch resources in" 
}
variable "suspended_processes" {
    description = "A list of processes to suspend for the Auto Scaling Group"
    default = []
}
variable "termination_policies" {
    description = "A list of policies to decide how the instances in the Auto Scaling Group should be terminated"
    default = ["OldestInstance"]
}
variable "tag" {
    description = "Tags for the ASG"
}

resource "aws_autoscaling_group" "asg" {
    name                            = var.name
    name_prefix                     = var.name_prefix
    min_size                        = var.min_size
    max_size                        = var.max_size
    desired_capacity                = var.desired_capacity
    default_cooldown                = var.default_cooldown
    health_check_grace_period       = var.health_check_grace_period
    health_check_type               = var.health_check_type
    launch_configuration            = var.launch_configuration
    target_group_arns               = var.target_group_arns
    termination_policies            = var.termination_policies
    suspended_processes             = var.suspended_processes
    load_balancers                  = var.load_balancers
    vpc_zone_identifier             = var.subnets
    dynamic "tag" {
        for_each = var.tag
        content {
            key                     = lookup(tag.value, "key")
            value                   = lookup(tag.value, "value")
            propagate_at_launch     = lookup(tag.value, "propagate_at_launch")
        }
    }
    lifecycle {
        create_before_destroy = true
    }
}
output "asg-id" { 
    value = aws_autoscaling_group.asg.id
}
output "asg-arn" {
    value = aws_autoscaling_group.asg.arn
}
output "asg-name" {
    value = aws_autoscaling_group.asg.name
}