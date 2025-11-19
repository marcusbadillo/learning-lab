###############################################################################
# AWS Provider Configuration
###############################################################################
provider "aws" {
  region  = var.aws_region        # Region where all resources will be deployed.
                                  # Bedrock, KBs, and some models are region-specific.

  profile = var.aws_profile       # AWS CLI profile to authenticate with.
                                  # profile must have sufficient permissions and be configured locally (~/.aws/creds, /config ).

                                  # LAB ONLY: In production, remove this and use IAM roles.
}

###############################################################################
# VPC (Virtual Private Cloud)
# This creates foundational networking for the entire stack:
# - Private subnets for Aurora Serverless
# - Public subnets for NAT gateways
# - DNS support for internal resolution (required for RDS/Aurora)
###############################################################################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  # Name applied to the VPC and associated resources
  name = var.vpc_name

  # Primary CIDR block for the VPC
  cidr = var.vpc_cidr

  # Availability Zones used in this region (3 AZs = high availability design)
  azs = var.vpc_azs

  # Private subnets – ONLY resources inside VPC can reach Aurora
  # Aurora Serverless will be placed in these subnets.
  private_subnets = var.private_subnets

  # Public subnets – where NAT gateways will live
  public_subnets = var.public_subnets

  # NAT Gateway is required for private subnets to reach AWS services
  # like Bedrock, S3, RDS API endpoints, etc.
  enable_nat_gateway = true
  single_nat_gateway = true        # Cost-saving: uses only 1 NAT for all AZs

  # DNS is required for Aurora Serverless V2 + RDS connection endpoints
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Useful metadata
  tags = var.tags
}

###############################################################################
# Aurora Serverless V2 Cluster
# Uses the custom module in ../modules/database
# This module:
# - Creates the Aurora cluster
# - Creates an instance
# - Creates security groups
# - Generates a secure master password
###############################################################################
module "aurora_serverless" {
  source = "../modules/database"   # Local module path

  # Cluster name prefix
  cluster_identifier = var.aurora_cluster_identifier

  # Place Aurora inside the private subnets of our VPC
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Overrides for database configuration
  database_name    = var.database_name   # Your application's logical DB name
  master_username  = var.master_username # DB admin user (password generated automatically)
  max_capacity     = var.aurora_max_capacity # Aurora Serverless V2 capacity scaling (1 = smallest)
  min_capacity     = var.aurora_min_capacity

  # Security rule: allow traffic from inside the VPC’s CIDR ONLY
  # Very restrictive, highly secure.
  allowed_cidr_blocks = var.allowed_cidr_blocks
}

###############################################################################
# Caller Identity – needed to dynamically create bucket names tied to your account
###############################################################################
data "aws_caller_identity" "current" {}

###############################################################################
# Local Variables
# Construct an S3 bucket name based on your AWS account ID.
# This ensures uniqueness across AWS and follows recommended naming patterns.
###############################################################################
locals {
  bucket_name = "${var.s3_bucket_prefix}-${data.aws_caller_identity.current.account_id}"
}

###############################################################################
# S3 Bucket for Knowledge Base Documents
# - Used to store source documents for Bedrock KB ingestion
# - Private, encrypted, versioned
# - Fully locked down (no public access)
###############################################################################
module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  # Unique bucket name created automatically from account ID
  bucket = local.bucket_name

  # S3 permissions & destruction behavior
  acl           = "private"
  force_destroy = true            # ALLOW DELETE even if objects exist (lab convenience)

  # Ownership settings (required for some S3 Block Public Access rules)
  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  # Versioning ensures:
  # - Document history
  # - Easier debugging for KB ingestion
  versioning = {
    enabled = true
  }

  # Encrypt objects with AES256 server-side encryption
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  # STRONG SECURITY: Block ALL public access paths
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # Standard metadata
  tags = var.tags
}
