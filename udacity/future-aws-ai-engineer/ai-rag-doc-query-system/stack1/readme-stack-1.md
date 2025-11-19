<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.21.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora_serverless"></a> [aurora\_serverless](#module\_aurora\_serverless) | ../modules/database | n/a |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | ~> 3.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | CIDR blocks allowed to connect to Aurora | `list(string)` | n/a | yes |
| <a name="input_aurora_cluster_identifier"></a> [aurora\_cluster\_identifier](#input\_aurora\_cluster\_identifier) | Identifier name for the Aurora cluster | `string` | n/a | yes |
| <a name="input_aurora_max_capacity"></a> [aurora\_max\_capacity](#input\_aurora\_max\_capacity) | Aurora Serverless maximum ACU scaling | `number` | n/a | yes |
| <a name="input_aurora_min_capacity"></a> [aurora\_min\_capacity](#input\_aurora\_min\_capacity) | Aurora Serverless minimum ACU scaling | `number` | n/a | yes |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | AWS CLI profile used for authentication | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy to | `string` | n/a | yes |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name of the Aurora database | `string` | n/a | yes |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | Master username for Aurora | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Private subnet CIDR blocks | `list(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | Public subnet CIDR blocks | `list(string)` | n/a | yes |
| <a name="input_s3_bucket_prefix"></a> [s3\_bucket\_prefix](#input\_s3\_bucket\_prefix) | Prefix used when creating the knowledge base bucket | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to all resources | `map(string)` | n/a | yes |
| <a name="input_vpc_azs"></a> [vpc\_azs](#input\_vpc\_azs) | Availability Zones to use | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR for the VPC | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aurora_arn"></a> [aurora\_arn](#output\_aurora\_arn) | n/a |
| <a name="output_aurora_endpoint"></a> [aurora\_endpoint](#output\_aurora\_endpoint) | n/a |
| <a name="output_db_endpoint"></a> [db\_endpoint](#output\_db\_endpoint) | n/a |
| <a name="output_db_reader_endpoint"></a> [db\_reader\_endpoint](#output\_db\_reader\_endpoint) | n/a |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | n/a |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | n/a |
| <a name="output_rds_secret_arn"></a> [rds\_secret\_arn](#output\_rds\_secret\_arn) | n/a |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_TF_DOCS -->