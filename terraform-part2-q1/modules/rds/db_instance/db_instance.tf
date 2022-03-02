variable "allocated_storage" {
    description = "The allocated storage in gibibytes"
    default = null
}
variable "allow_major_version_upgrade" {
    description = "Indicates that major version upgrades are allowed"
    default = true
}
variable "apply_immediately" {
    description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
    default = false
}
variable "auto_minor_version_upgrade" {
    description = " Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
    default = true
}
variable "availability_zone" {
    description = "The AZ for the RDS instance"
    default = null
}
variable "backup_retention_period" {
    description = "The days to retain backups for. Must be between 0 and 35"
    default = 7
}
variable "backup_window" {
    description = "The daily time range (in UTC) during which automated backups are created if they are enabled"
    default = "23:00-00:00"
}
variable "ca_cert_identifier" {
    description = "The identifier of the CA certificate for the DB instance"
    default = null
}
variable "character_set_name" {
    description = "The character set name to use for DB encoding in Oracle and Microsoft SQL instances"
    default = null
}
variable "copy_tags_to_snapshot" {
    description = "Copy all Instance tags to snapshots"
    default = true
}
variable "db_subnet_group_name" {
    description = "Name of DB subnet group"
    default = null
}
variable "delete_automated_backups" {
    description = "Specifies whether to remove automated backups immediately after the DB instance is deleted"
    default = true
}
variable "deletion_protection" {
    description = "If the DB instance should have deletion protection enabled"
    default = false
}
variable "domain" {
    description = "The ID of the Directory Service Active Directory domain to create the instance in"
    default = null
}
variable "domain_iam_role_name" {
    description = "The name of the IAM role to be used when making API calls to the Directory Service"
    default = null
}
variable "enabled_cloudwatch_logs_exports" {
    description = "Set of log types to enable for exporting to CloudWatch logs. Valid values: audit, error, general, slowquery"
    default = null
}
variable "engine" {
    description = "The database engine to use"
    default = "mysql"
}
variable "engine_version" {
    description = "The engine version to use"
    default = "8.0"
}
variable "final_snapshot_identifier" {
    description = "The name of your final DB snapshot when this DB instance is deleted"
    default = null
}
variable "iam_database_authentication_enabled" {
    description = "Specifies whether or mappings of IAM accounts to database accounts is enabled"
    default = null
}
variable "identifier" {
    description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
    default = null
}
variable "identifier_prefix" {
    description = "Creates a unique identifier beginning with the specified prefix"
    default = null
}
variable "instance_class" {
    description = "The instance type of the RDS instance"
}
variable "iops" {
    description = "The amount of provisioned IOPS. Setting this implies a storage_type of io1"
    default = null
}
variable "kms_key_id" {
    description = "The ARN for the KMS encryption key"
    default = null
}
variable "license_model" {
    description = "License model information for this DB instance"
    default = null
}
variable "maintenance_window" {
    description = "The window to perform maintenance in"
    default = "Sun:00:05-Sun:05:00"
}
variable "max_allocated_storage" {
    description = "the upper limit to which Amazon RDS can automatically scale the storage of the DB instance"
    default = 0
}
variable "monitoring_interval" {
    description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance"
    default = 0
}
variable "monitoring_role_arn" {
    description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
    default = null
}
variable "multi_az" {
    description = "Specifies if the RDS instance is multi-AZ"
    default = false
}
variable "name" {
    description = "The name of the database to create when the DB instance is created"
}
variable "nchar_character_set_name" {
    description = "The national character set is used in the NCHAR, NVARCHAR2, and NCLOB data types for Oracle instances"
    default = null
}
variable "option_group_name" {
    description = "Name of the DB option group to associate"
    default = null
}
variable "parameter_group_name" {
    description = "Name of the DB parameter group to associate"
    default = null
}
variable "password" {
    description = "Password for the master DB user"
    default = null
}
variable "performance_insights_enabled" {
    description = "Specifies whether Performance Insights are enabled"
    default = false
}
variable "performance_insights_kms_key_id" {
    description = "The ARN for the KMS key to encrypt Performance Insights data"
    default = null
}
variable "performance_insights_retention_period" {
    description = "The amount of time in days to retain Performance Insights data"
    default = null
}
variable "port" {
    description = "The port on which the DB accepts connections"
    default = null
}
variable "publicly_accessible" {
    description = "Bool to control if instance is publicly accessible"
    default = false
}
variable "replicate_source_db" {
    description = "Specifies that this resource is a Replicate database, and to use this value as the source database"
    default = null
}
variable "restore_to_point_in_time" {
    description = "A configuration block for restoring a DB instance to an arbitrary point in time"
    default = {}
}
variable "s3_import" {
    description = "Restore from a Percona Xtrabackup in S3"
    default = {}
}
variable "security_group_names" {
    description = "List of DB Security Groups to associate"
    default = []
}
variable "skip_final_snapshot" {
    description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
    default = false
}
variable "snapshot_identifier" {
    description = "Specifies whether or not to create this database from a snapshot"
    default = null
}
variable "storage_encrypted" {
    description = "Specifies whether the DB instance is encrypted"
    default = false
}
variable "storage_type" {
    description = "One of standard, gp2, or io1"
    default = "gp2"
}
variable "tags" {
    description = "Tags for the db instance"
    default = {}
}
variable "timezone" {
    description = "Time zone of the DB instance"
    default = null
}
variable "username" {
    description = "Username for the master DB user."
}
variable "vpc_security_group_ids" {
    description = "List of VPC security groups to associate"
    default = null
}
variable "customer_owned_ip_enabled" {
    description = "Indicates whether to enable a CoIP for an RDS on Outposts DB instance"
    default = null
}


resource "aws_db_instance" "db_instance" {
    allocated_storage                      = var.allocated_storage
    allow_major_version_upgrade            = var.allow_major_version_upgrade
    apply_immediately                      = var.apply_immediately
    auto_minor_version_upgrade             = var.auto_minor_version_upgrade
    availability_zone                      = var.availability_zone
    backup_retention_period                = var.backup_retention_period
    backup_window                          = var.backup_window
    ca_cert_identifier                     = var.ca_cert_identifier
    character_set_name                     = var.character_set_name
    copy_tags_to_snapshot                  = var.copy_tags_to_snapshot
    db_subnet_group_name                   = var.db_subnet_group_name
    delete_automated_backups               = var.delete_automated_backups
    deletion_protection                    = var.deletion_protection
    domain                                 = var.domain
    domain_iam_role_name                   = var.domain_iam_role_name
    enabled_cloudwatch_logs_exports        = var.enabled_cloudwatch_logs_exports
    engine                                 = var.engine
    engine_version                         = var.engine_version
    final_snapshot_identifier              = var.final_snapshot_identifier
    iam_database_authentication_enabled    = var.iam_database_authentication_enabled
    identifier                             = var.identifier
    identifier_prefix                      = var.identifier_prefix
    instance_class                         = var.instance_class
    iops                                   = var.iops
    kms_key_id                             = var.kms_key_id
    license_model                          = var.license_model
    maintenance_window                     = var.maintenance_window
    max_allocated_storage                  = var.max_allocated_storage
    monitoring_interval                    = var.monitoring_interval
    monitoring_role_arn                    = var.monitoring_role_arn
    multi_az                               = var.multi_az
    name                                   = var.name
    nchar_character_set_name               = var.nchar_character_set_name
    option_group_name                      = var.option_group_name
    parameter_group_name                   = var.parameter_group_name
    password                               = var.password
    performance_insights_enabled           = var.performance_insights_enabled
    performance_insights_kms_key_id        = var.performance_insights_kms_key_id
    performance_insights_retention_period  = var.performance_insights_retention_period
    port                                   = var.port
    publicly_accessible                    = var.publicly_accessible
    replicate_source_db                    = var.replicate_source_db
    security_group_names                   = var.security_group_names
    skip_final_snapshot                    = var.skip_final_snapshot
    snapshot_identifier                    = var.snapshot_identifier
    storage_encrypted                      = var.storage_encrypted
    storage_type                           = var.storage_type
    tags                                   = var.tags
    timezone                               = var.timezone
    username                               = var.username
    vpc_security_group_ids                 = var.vpc_security_group_ids
    customer_owned_ip_enabled              = var.customer_owned_ip_enabled
    dynamic "restore_to_point_in_time" {
        for_each = var.restore_to_point_in_time
        content {
            restore_time                   = lookup(restore_to_point_in_time.value, "restore_time", null)
            source_db_instance_identifier  = lookup(restore_to_point_in_time.value, "source_db_instance_identifier", null)
            source_dbi_resource_id         = lookup(restore_to_point_in_time.value, "source_dbi_resource_id", null)
            use_latest_restorable_time     = lookup(restore_to_point_in_time.value, "use_latest_restorable_time", null)
        }
    }
    dynamic "s3_import" {
        for_each = var.s3_import
        content {
            bucket_name                    = s3_import.value.bucket_name
            bucket_prefix                  = lookup(s3_import.value, "bucket_prefix", null)
            ingestion_role                 = s3_import.value.ingestion_role
            source_engine                  = s3_import.value.source_engine
            source_engine_version          = s3_iumport.value.source_engine_version
        }
    }
}

output "db_address" {
    value = aws_db_instance.db_instance.address
}
output "db_arn" {
    value = aws_db_instance.db_instance.arn
}
output "db_allocated_storage" {
    value = aws_db_instance.db_instance.allocated_storage
}
output "db_endpoint" {
    value = aws_db_instance.db_instance.endpoint
}
output "db_id" {
    value = aws_db_instance.db_instance.id
}
output "db_name" {
    value = aws_db_instance.db_instance.name
}
output "db_port" {
    value = aws_db_instance.db_instance.port
}
output "db_master_username" {
    value = aws_db_instance.db_instance.username
}
output "db_status" {
    value = aws_db_instance.db_instance.status
}
output "db_resource_id" {
    value = aws_db_instance.db_instance.resource_id
}
