provider "aws" {
    region               = "eu-central-1"
    default_tags {
        tags = {
            Environment  = "prod"
        }
    }
}

terraform {
    backend "s3" {
        bucket           = "terraform15-state"
        key              = "prod-two-tier/terraform.tfstate"
        region           = "us-west-1"
    }
}


data "aws_availability_zones" "available" {
    state = "available"
}


data "aws_subnet_ids" "public" {
    vpc_id = module.prod-vpc.vpc-id
    tags = {
        Privacy = "public"
    }
}

data "aws_subnet_ids" "private" {
    vpc_id = module.prod-vpc.vpc-id
    tags = {
        Privacy = "private"
    }
}

data "aws_iam_role" "prod-role" {
    name = "prod-app-role"
}

data "aws_ami" "prod-ami" {
    most_recent = true
    owners = ["self"]
    filter {
        name      = "name"
        values    = ["baseAmi-common-*"]
    }
}


data "template_file" "userdata" {
    template = "${file("${path.module}/userdata.sh.tpl")}"
}


data "aws_kms_key" "aws_rds" {
    key_id = "alias/aws/rds"
}