variable "traffic_type" {
    description = "The type of traffic to capture. Valid values: ACCEPT,REJECT, ALL"
    default = "ALL"
}
variable "eni_id" {
    description = "ENI ID to attach to"
    default = null
}
variable "iam_role_arn" {
    description = "The ARN for the IAM role that's used to post flow logs to a CloudWatch Logs log group"
    default = null
}
variable "log_destination_type" {
    description = "The type of the logging destination. Valid values: cloud-watch-logs, s3"
    default = "cloud-watch-logs"
}
variable "log_destination" {
    description = "ARN of log destination"
    default = null
}
variable "subnet_id" {
    description = "SubnetID to attach to"
    default = null
}
variable "vpc_id" {
    description = "VPC ID to attach to"
    default = null
}
variable "log_format" {
    description = "The fields to include in the flow log record, in the order in which they should appear."
    default = null
}
variable "max_aggregation_interval" {
    description = "The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record"
    default = 600
}
variable "destination_options" {
    description = "Describes the destination options for a flow log"
    default = { }
}
variable "tags" {
    description = "tags for FlowLog"
}

resource "aws_flow_log" "flow_log" {
    traffic_type                        = var.traffic_type
    eni_id                              = var.eni_id
    iam_role_arn                        = var.iam_role_arn
    log_destination_type                = var.log_destination_type
    log_destination                     = var.log_destination
    subnet_id                           = var.subnet_id
    vpc_id                              = var.vpc_id
    log_format                          = var.log_format
    max_aggregation_interval            = var.max_aggregation_interval
    tags                                = var.tags
    dynamic "destination_options" {
        for_each = var.destination_options
        content {
            file_format                 = lookup(destination_options.value, "file_format", "plain-text")
            hive_compatible_partitions  = lookup(destination_options.value, "hive_compatible_partitions", false)
            per_hour_partition          = lookup(destination_options.value, "per_hour_partition", false)
        }
    }
}

output "flow_log_id" {
    value                         = aws_flow_log.flow_log.id
}
output "flow_log_arn" {
    value                         = aws_flow_log.flow_log.arn
}
