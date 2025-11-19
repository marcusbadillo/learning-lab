###############################################################################
# Provider Variables
###############################################################################
variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile used for authentication"
  type        = string
}

###############################################################################
# VPC Variables
###############################################################################
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
}

variable "vpc_azs" {
  description = "Availability Zones to use"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
}

###############################################################################
# Aurora Variables
###############################################################################
variable "aurora_cluster_identifier" {
  description = "Identifier name for the Aurora cluster"
  type        = string
}

variable "database_name" {
  description = "Name of the Aurora database"
  type        = string
}

variable "master_username" {
  description = "Master username for Aurora"
  type        = string
}

variable "aurora_max_capacity" {
  description = "Aurora Serverless maximum ACU scaling"
  type        = number
}

variable "aurora_min_capacity" {
  description = "Aurora Serverless minimum ACU scaling"
  type        = number
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to connect to Aurora"
  type        = list(string)
}

###############################################################################
# S3 Variables
###############################################################################
variable "s3_bucket_prefix" {
  description = "Prefix used when creating the knowledge base bucket"
  type        = string
}

###############################################################################
# Tag Variables
###############################################################################
variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
}
