module "prod-vpc" {
    source                             = "../modules/vpc"
    cidr_block                         = "10.10.0.0/16"
    tags = {
        "Name"                         = "prod-vpc"
    }
}

# module "prod-vpc-flow-log" {
#     source                        = "../modules/vpc_flow_logs"
#     traffic_type                  = "ALL"
#     log_destination_type          = "s3"
#     log_destination               = "arn:aws:s3:::prod-vpc-flowlogs"
#     vpc_id                        = module.prod-vpc.vpc_id
#     log_format                    = "$${account-id} $${action} $${az-id} $${bytes} $${dstaddr} $${dstport} $${end} $${flow-direction} $${instance-id} $${interface-id} $${log-status} $${packets} $${pkt-dst-aws-service} $${pkt-dstaddr} $${pkt-src-aws-service} $${pkt-srcaddr} $${protocol} $${region} $${srcaddr} $${srcport} $${start} $${sublocation-id} $${sublocation-type} $${subnet-id} $${tcp-flags} $${traffic-path} $${type} $${version} $${vpc-id}"
#     max_aggregation_interval      = 60
#     destination_options = [{
#         file_format               = "plain-text"
#         per_hour_partition        = "true"
#     }]
#     tags = {
#         Name                      = "prod-vpc-flow-log"
#     }  
# }


module "prod-vpc-private-subnet-1" {
    source                                = "../modules/subnet"
    availability_zone                     = data.aws_availability_zones.available.names[0]
    cidr_block                            = "10.10.2.0/24"
    vpc_id                                = module.prod-vpc.vpc-id
    tags = {
        "Name"                            = "prod-vpc-private-subnet-1"
        "Privacy"                         = "private"
    }
}

module "prod-vpc-private-subnet-2" {
    source                                = "../modules/subnet"
    availability_zone                     = data.aws_availability_zones.available.names[1]
    cidr_block                            = "10.10.3.0/24"
    vpc_id                                = module.prod-vpc.vpc-id
    tags = {
        "Name"                            = "prod-vpc-private-subnet-2"
        "Privacy"                         = "private"
    }
}

module "prod-vpc-public-subnet-1" {
    source                                = "../modules/subnet"
    availability_zone                     = data.aws_availability_zones.available.names[0]
    cidr_block                            = "10.10.0.0/24"
    map_public_ip_on_launch               = true
    vpc_id                                = module.prod-vpc.vpc-id
    tags = {
        "Name"                            = "prod-vpc-public-subnet-1"
        "Privacy"                         = "public"
    }
}


module "prod-vpc-public-subnet-2" {
    source                                = "../modules/subnet"
    availability_zone                     = data.aws_availability_zones.available.names[1]
    cidr_block                            = "10.10.1.0/24"
    map_public_ip_on_launch               = true
    vpc_id                                = module.prod-vpc.vpc-id
    tags = {
        "Name"                            = "prod-vpc-public-subnet-2"
        "Privacy"                         = "public"
    }
}


module "prod-vpc-igw" {
    source             = "../modules/internet_gateway"
    vpc_id             = module.prod-vpc.vpc-id
    tags = {
        "Name"         = "prod-vpc-igw"
        "Privacy"      = "public"
    }
}

module "prod-vpc-nat-gateway-eip" {
    source                       = "../modules/elastic_ip"
    tags = {
        "Name"                   = "prod-vpc-nat-gateway-eip"
    }
    vpc                          = true
}

module "prod-vpc-nat-gateway" {
    source                  = "../modules/nat_gateway"
    allocation_id           = module.prod-vpc-nat-gateway-eip.eip_id
    subnet_id               = module.prod-vpc-public-subnet-2.subnet_id
    connectivity_type       = "public"
    tags = {
        Name                = "prod-vpc-nat-gateway"
        Privacy             = "public"
    }
}


module "prod-vpc-private-route-table-1" {
    source                                 = "../modules/route_table"
    vpc_id                                 = module.prod-vpc.vpc-id
    route = [{
        cidr_block                         = "0.0.0.0/0"
        nat_gateway_id                     = module.prod-vpc-nat-gateway.nat_gateway_id
    }]
    tags = {
        "Name"                             = "prod-vpc-private-route-table-1"
        "Privacy"                          = "private"
    }
}

module "prod-vpc-private-RT1-private-subnet1-association" {
    source                                 = "../modules/route_table_association"
    subnet_id                              = module.prod-vpc-private-subnet-1.subnet_id
    route_table_id                         = module.prod-vpc-private-route-table-1.route_table_id
}

module "prod-vpc-private-RT1-private-subnet2-association" {
    source                                 = "../modules/route_table_association"
    subnet_id                              = module.prod-vpc-private-subnet-2.subnet_id
    route_table_id                         = module.prod-vpc-private-route-table-1.route_table_id
}

module "prod-vpc-public-route-table-1" {
    source                                 = "../modules/route_table"
    vpc_id                                 = module.prod-vpc.vpc-id
    route = [{
        cidr_block                         = "0.0.0.0/0"
        gateway_id                         = module.prod-vpc-igw.igw_id
    }]
    tags = {
        "Name"                             = "prod-vpc-public-route-table-1"
        "Privacy"                          = "public"
    }
}

module "prod-vpc-public-RT1-public-subnet1-association" {
    source                                 = "../modules/route_table_association"
    subnet_id                              = module.prod-vpc-public-subnet-1.subnet_id
    route_table_id                         = module.prod-vpc-public-route-table-1.route_table_id
}

module "prod-vpc-public-RT1-public-subnet2-association" {
    source                                 = "../modules/route_table_association"
    subnet_id                              = module.prod-vpc-public-subnet-2.subnet_id
    route_table_id                         = module.prod-vpc-public-route-table-1.route_table_id
}


module "prod-app-security-group" {
    source                                 = "../modules/security_groups"
    description                            = "SG for prod-app"
    egress = [{
        from_port                          = 0
        to_port                            = 0
        cidr_blocks                        = ["0.0.0.0/0"]
        protocol                           = "-1"
    }]
    ingress = {
        from_port                          = 80
        to_port                            = 80
        cidr_blocks                        = ["0.0.0.0/0"]
        protocol                           = "-1"
    }
    name                                   = "prod-app-sg"
    tags = {
        Name                               = "prod-app-sg"
        Application                        = "prod-app"
    }
    vpc_id                                 = module.prod-vpc.vpc-id
}

module "prod-app-inbound-rule" {
    source                       = "../modules/security_group_rule"
    from_port                    = 443
    protocol                     = "tcp"
    security_group_id            = module.prod-app-security-group.security_group_id
    to_port                      = 443
    type                         = "ingress"
    # cidr_blocks                  = var.cidr_blocks
    # description                  = var.description
    # ipv6_cidr_blocks             = var.ipv6_cidr_blocks
    # prefix_list_ids              = var.prefix_list_ids
    self                         = true
}


module "prod-launch-configuration" {
    source                         = "../modules/asg/launch_configuration"
    name                           = "prod-v1"
    image_id                       = data.aws_ami.prod.id
    instance_type                  = "r5.large"
    iam_instance_profile           = data.aws_iam_role.prod-role.id
    security_groups                = [module.prod-app-security-group.security_group_id]
    key_name                       = "prod-ssh-key"
    user_data                      = data.template_file.userdata.rendered
    root_volume_size               = "30"
    root_volume_type               = "gp3"
    root_delete_on_termination     = "false"
}

module "prod-asg" {
    source                    = "../modules/asg/autoScaling_Group"
    name                      = "prod-asg"
    min_size                  = 1
    max_size                  = 4
    desired_capacity          = 1
    default_cooldown          = 300
    health_check_grace_period = 0
    health_check_type         = "EC2"
    launch_configuration      = module.prod-launch-configuration.lc-id
    subnets                   = data.aws_subnet_ids.public.ids
    tag = [{
        key                   = "Name"
        value                 = "prod-app"
        propagate_at_launch   = true
    },
    {
        key                   = "Environment"
        value                 = "prod"
        propagate_at_launch   = true
    },
    {
        key                   = "Application"
        value                 = "ProdTest"
        propagate_at_launch   = true
    },
    {
        key                   = "BaseAmi"
        value                 = data.aws_ami.prod-ami.id
        propagate_at_launch   = true
    }]
}



module "rds-security-group" {
    source                                 = "../modules/security_groups"
    description                            = "SG for prod-rds"
    egress = [{
        from_port                          = 0
        to_port                            = 0
        cidr_blocks                        = ["0.0.0.0/0"]
        protocol                           = "-1"
    }]
    ingress = { }
    name                                   = "prod-rds-sg"
    tags = {
        Name                               = "prod-rds-sg"
        Application                        = "RDS"
    }
    vpc_id                                 = module.prod-vpc.vpc-id
}

module "prod-rds-option-group" {
    source                    = "../modules/rds/db_option_group"
    name                      = "prod-rds-option-group"
    engine_name               = "postgres"
    major_engine_version      = "10"
    tags = {
        Name                  = "prod-rds-option-group"
        Engine                = "postgres"
    }
} 

module "prod-rds-subnet-group" { 
    source                    = "../modules/rds/db_subnet_group"
    name                      = "prod-rds-subnet-group"
    subnet_ids                = data.aws_subnet_ids.private.ids
    tags = {
        Name                  = "prod-rds-subnet-group"
        Engine                = "postgres"
    }
}

module "prod-rds-parameter-group" {
    source                    = "../modules/rds/db_parameter_group"
    name                      = "prod-rds-parameter-group"
    family                    = "postgres10"
    tags = {
        Name                  = "prod-rds-parameter-group"
        Engine                = "postgres"
    }
    parameter = [{
        name           = "autovacuum_analyze_threshold"
        value          = 1000
        apply_method   = "pending-reboot"
    },
    {
        name           = "pg_stat_statements.max"
        value          = 10000
        apply_method   = "pending-reboot"
    },
    {
        name           = "shared_preload_libraries"
        value          = "pg_stat_statements"
        apply_method   = "pending-reboot"
    },
    {
        name           = "pg_stat_statements.track"
        value          = "ALL"
        apply_method   = "pending-reboot"
    }]
}

module "prod-rds" {
    source                                 = "../modules/rds/db_instance"
    allocated_storage                      = 70
    auto_minor_version_upgrade             = false
    # availability_zone                      = data.aws_availability_zones.available.names[0]
    backup_retention_period                = 7
    backup_window                          = "04:00-04:30"
    copy_tags_to_snapshot                  = true
    db_subnet_group_name                   = module.prod-rds-subnet-group.db_subnet_group_name
    deletion_protection                    = true
    enabled_cloudwatch_logs_exports        = ["postgresql", "upgrade"]
    engine                                 = "postgres"
    engine_version                         = "10.16"
    final_snapshot_identifier              = "prod-rds-final-snapshot"
    instance_class                         = "db.m5.large"
    identifier                             = "prod-rds"
    kms_key_id                             = data.aws_kms_key.aws_rds.arn
    option_group_name                      = module.prod-rds-option-group.db_option_group_name
    parameter_group_name                   = module.prod-rds-parameter-group.db_parameter_group_name
    maintenance_window                     = "Tue:10:31-Tue:11:01"
    multi_az                               = true
    name                                   = "prodRds"
    password                               = "enterYourMasterPassHere"
    port                                   = 5432
    storage_type                           = "gp2"
    storage_encrypted                      = true
    tags                                   = {
        Name                               = "prod-db"
        Engine                             = "postgres"
    }
    username                               = "prod"
    vpc_security_group_ids                 = [module.rds-security-group.security_group_id]
}
