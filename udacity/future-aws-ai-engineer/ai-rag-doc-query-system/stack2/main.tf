provider "aws" {
  region = "us-west-2"  
  profile = "udacity-aws-lab-1" 
}

module "bedrock_kb" {
  source = "../modules/bedrock_kb" 
  knowledge_base_name        = "my-bedrock-kb"
  knowledge_base_description = "Knowledge base connected to Aurora Serverless database"
  #TODO Update with output from stack1
  aurora_arn        = "arn:aws:rds:us-west-2:702043267423:cluster:my-aurora-serverless" 
  aurora_db_name    = "myapp"
  # TODO Update with output from stack1
  aurora_endpoint   = "my-aurora-serverless.cluster-cbjfe4owdrv8.us-west-2.rds.amazonaws.com" 
  aurora_table_name = "bedrock_integration.bedrock_kb"
  aurora_primary_key_field = "id"
  aurora_metadata_field = "metadata"
  aurora_text_field = "chunks"
  aurora_verctor_field = "embedding"
  aurora_username   = "dbadmin"
  #TODO Update with output from stack1
  aurora_secret_arn = "arn:aws:secretsmanager:us-west-2:702043267423:secret:my-aurora-serverless-VLhOWf" 
  #TODO Update with output from stack1
  s3_bucket_arn = "arn:aws:s3:::bedrock-kb-702043267423"
}