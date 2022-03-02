variable "name" {
    description = "The name of the launch template"
}
variable "name_prefix" {
    description = "The name prefix of the launch template"
    default = null
}
variable "description" {
    description = "The description of the launch template"
    default = null
}
variable "default_version" {
    description = "Default Version of the launch template"
    default = null
}
variable "update_default_version" {
    description = "Update Default Version of the launch template"
    default = false
}
variable "block_device_mappings" {
    description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"
    default = {}
}
variable "capacity_reservation_specification" {
    description = "Targeting for EC2 capacity reservations"
    default = {}
}
variable "cpu_options" {
    description = "The CPU options for the instance"
    default = {}
}
variable "cpu_credits" {
    description = "The credit option for the instance"
    default = "standard"
}
variable "disable_api_termination" {
    description = "Whether or not to disable API termination"
    default = false
}
variable "ebs_optimized" {
    description = "Whether or not to use EBS optimized instance"
    default = false
}
variable "elastic_gpu_specifications" {
    description = "The elastic GPU type for the instance"
    default = {}
}
variable "elastic_inference_accelerator" {
    description = "The elastic inference accelerator specifications for the instance"
    default = {}
}
variable "iam_instance_profile" {
    description = "The IAM instance profile to associate with the instance"
    default = {}
}
variable "image_id" {
    description = "The ID of the AMI to use"
    default = null
}
variable "instance_initiated_shutdown_behavior" {
    description = "The behavior of the instance when it is shut down"
    default = null
}
variable "instance_market_options" {
    description = "The market options for the instance"
    default = {}
}
variable "instance_type" {
    description = "The type of instance to launch"
    default = null
}
variable "kernel_id" {
    description = "The ID of the kernel to use"
    default = null
}
variable "key_name" {
    description = "The name of the key pair to use"
    default = null
}
variable "license_specification" {
    description = "The license specifications for the instance"
    default = {}
}
variable "metadata_options" {
    description = "The metadata options for the instance"
    default = {}
}
variable "monitoring" {
    description = "Whether or not to enable detailed monitoring"
    default = false
}
variable "network_interfaces" {
    description = "The network interfaces for the instance"
    default = {}
}
variable "placement" {
    description = "The placement for the instance"
    default = {}
}
variable "ramdisk_id" {
    description = "The ID of the RAM disk to use"
    default = null
}
variable "security_group_names" {
    description = "The list of the security groups to apply to the instance"
    default = null
}
variable "vpc_security_group_ids" {
    description = "USe this when create in VPC. The list of the VPC security groups to apply to the instance"
    default = null
}
variable "tag_specifications" {
    description = "The tags to apply to the resources during launch"
    default = {}
}
variable "tags" {
    description = "The tags to apply to the resources during launch"
    default = {}
}
variable "user_data" {
    description = "The user data to apply to the instance"
    default = null
}
variable "hibernation_enabled" {
    description = "The hibernation options for the instance"
    default = false
}
variable "enclave_enabled" {
    description = "The enclave options for the instance"
    default = false
}

resource "aws_launch_template" "lc" {
    name                                           = var.name
    name_prefix                                    = var.name_prefix
    description                                    = var.description
    default_version                                = var.default_version
    update_default_version                         = var.update_default_version
    disable_api_termination                        = var.disable_api_termination
    ebs_optimized                                  = var.ebs_optimized
    image_id                                       = var.image_id
    instance_initiated_shutdown_behavior           = var.instance_initiated_shutdown_behavior
    # instance_market_options                        = var.instance_market_options
    instance_type                                  = var.instance_type
    kernel_id                                      = var.kernel_id
    key_name                                       = var.key_name
    ram_disk_id                                    = var.ramdisk_id
    security_group_names                           = var.security_group_names
    vpc_security_group_ids                         = var.vpc_security_group_ids
    # tag_specifications                             = var.tag_specifications
    tags                                           = var.tags
    user_data                                      = var.user_data
    dynamic "block_device_mappings" {
        for_each = var.block_device_mappings
        content {
            device_name                            = lookup(block_device_mappings.value, "device_name", null)
            no_device                              = lookup(block_device_mappings.value, "no_device", null)
            virtual_name                           = lookup(block_device_mappings.value, "virtual_name", null)
            dynamic "ebs" {
                for_each = block_device_mappings.value.ebs
                content {
                    delete_on_termination          = lookup(ebs.value, "delete_on_termination", false)
                    encrypted                      = lookup(ebs.value, "encrypted", false)
                    iops                           = lookup(ebs.value, "iops", null)
                    kms_key_id                     = lookup(ebs.value, "kms_key_id", null)
                    snapshot_id                    = lookup(ebs.value, "snapshot_id", null)
                    throughput                     = lookup(ebs.value, "throughput", null)
                    volume_size                    = lookup(ebs.value, "volume_size", null)
                    volume_type                    = lookup(ebs.value, "volume_type", "gp3")
                }
            }
        }
    }
    dynamic "capacity_reservation_specification" {
        for_each = var.capacity_reservation_specification
        content {
            capacity_reservation_preference        = lookup(capacity_reservation_specification.value, "capacity_reservation_preference", null)
            dynamic "capacity_reservation_target" {
                for_each = lookup(capacity_reservation_specification.value, "capacity_reservation_target", null)
                content {
                    capacity_reservation_id        = lookup(capacity_reservation_target.value, "capacity_reservation_id", null)
                }
            }
        }
    }
    dynamic "cpu_options" {
        for_each = var.cpu_options
        content {
            core_count                             = lookup(cpu_options.value, "core_count", null)
            threads_per_core                       = lookup(cpu_options.value, "threads_per_core", 2)
        }
    }
    credit_specification {
        cpu_credits                                = var.cpu_credits
    }
    dynamic "elastic_gpu_specifications" {
        for_each = var.elastic_gpu_specifications
        content {
            type                                    = lookup(elastic_gpu_specifications.value, "type", null)
        }
        # type                                       = var.elastic_gpu_type
    }
    dynamic "elastic_inference_accelerator" {
        for_each = var.elastic_inference_accelerator
        content {
            type                                    = lookup(elastic_inference_accelerator.value, "type", null)
        }
        # type                                       = var.elastic_inference_accelerator_type
    }
    dynamic "iam_instance_profile" {
        for_each = var.iam_instance_profile
        content {
            arn                                    = lookup(iam_instance_profile.value, "arn", null)
            name                                   = lookup(iam_instance_profile.value, "name", null)
        }
    }
    dynamic "license_specification" {
        for_each = var.license_specification
        content {
            license_configuration_arn             = lookup(license_specification.value, "license_configuration_arn", null)
        }
        # license_configuration_arn                  = var.license_configuration_arn
    }
    dynamic "instance_market_options" {
        for_each = var.instance_market_options
        content {
            market_type                            = lookup(instance_market_options.value, "market_type", null)
            dynamic "spot_options" {
                for_each = lookup(instance_market_options.value, "spot_options", null)
                content {
                    block_duration_minutes         = lookup(spot_options.value, "block_duration_minutes", null)
                    instance_interruption_behavior = lookup(spot_options.value, "instance_interruption_behavior", null)
                    max_price                      = lookup(spot_options.value, "max_price", null)
                    spot_instance_type             = lookup(spot_options.value, "spot_instance_type", null)
                    valid_until                    = lookup(spot_options.value, "valid_until", null)
                }
            }
        }
    }
    dynamic "metadata_options" {
        for_each = var.metadata_options
        content {
            http_endpoint                          = lookup(metadata_options.value, "http_endpoint", "enabled")
            http_put_response_hop_limit            = lookup(metadata_options.value, "http_put_response_hop_limit", 2)
            http_tokens                            = lookup(metadata_options.value, "http_ttl", "optional")
            http_protocol_ipv6                     = lookup(metadata_options.value, "http_protocol_ipv6", disabled)
            instance_metadata_tags                 = lookup(metadata_options.value, "instance_metadata_tags", true)
        }
    }
    monitoring {
        enabled                                    = var.monitoring
    }
    dynamic "network_interfaces" {
        for_each = var.network_interfaces
        content {
            associate_carrier_ip_address           = lookup(network_interfaces.value, "associate_carrier_ip_address", false)
            associate_public_ip_address            = lookup(network_interfaces.value, "associate_public_ip_address", null)
            delete_on_termination                  = lookup(network_interfaces.value, "delete_on_termination", false)
            description                            = lookup(network_interfaces.value, "description", null)
            device_index                           = lookup(network_interfaces.value, "device_index", null)
            interface_type                         = lookup(network_interfaces.value, "interface_type", null)
            ipv6_address_count                     = lookup(network_interfaces.value, "ipv6_address_count", null)
            ipv6_addresses                         = lookup(network_interfaces.value, "ipv6_addresses", null)
            network_interface_id                   = lookup(network_interfaces.value, "network_interface_id", null)
            network_card_index                     = lookup(network_interfaces.value, "network_card_index", null)
            private_ip_address                     = lookup(network_interfaces.value, "private_ip_address", null)
            ipv4_address_count                     = lookup(network_interfaces.value, "ipv4_address_count", null)
            ipv4_addresses                         = lookup(network_interfaces.value, "ipv4_addresses", null)
            security_groups                        = lookup(network_interfaces.value, "security_groups", null)
            subnet_id                              = lookup(network_interfaces.value, "subnet_id", null)
        }
    }
    dynamic "placement" {
        for_each = var.placement
        content {
            affinity                               = lookup(placement.value, "affinity", null)
            availability_zone                      = lookup(placement.value, "availability_zone", null)
            group_name                             = lookup(placement.value, "group_name", null)
            host_id                                = lookup(placement.value, "host_id", null)
            host_resource_group_arn                = lookup(placement.value, "host_resource_group_arn", null)
            spread_domain                          = lookup(placement.value, "spread_domain", null)
            tenancy                                = lookup(placement.value, "tenancy", default)
            partition_number                       = lookup(placement.value, "partition_number", null)
        }
    }
    hibernation_options {
        configured                                 = var.hibernation_enabled
    }
    enclave_options {
        enabled                                    = var.enclave_enabled
    }
    dynamic "tag_specifications" {
        for_each = var.tag_specifications
        content {
            resource_type                          = lookup(tag_specifications.value, "resource_type", null)
            tags                                   = lookup(tag_specifications.value, "tags", null)
        }
    }
}