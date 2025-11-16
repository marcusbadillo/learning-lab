# Future AWS AI Engineer

## Tools

[Amazon SageMaker AI](https://docs.aws.amazon.com/sagemaker/latest/dg/whatis.html)

[Amazon SageMaker Clarify](https://aws.amazon.com/sagemaker/clarify/) - Fairness and Bias Mitigation with Amazon SageMaker Clarify

[Amazon SageMaker Model Cards](https://docs.aws.amazon.com/sagemaker/latest/dg/model-cards.html) - Building Transparent AI with SageMaker Model Cards

[Amazon SageMaker Model Monitor](https://aws.amazon.com/sagemaker/model-monitor/) - ML Governance with Amazon SageMaker

[Amazon SageMaker Role Manager](https://docs.aws.amazon.com/sagemaker/latest/dg/role-manager.html) - AI Governance with Amazon SageMaker Role Manager
  
[Amazon S3 Lifecycle Policies](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lifecycle-mgmt.html) – Manages data retention and deletion policies to maintain compliance.

[Amazon Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-bedrock.html) - Amazon Bedrock for Generative AI and Content Filtering

[Playgrounds](https://docs.aws.amazon.com/bedrock/latest/userguide/playgrounds.html)

[Prompt Engineering Guidelines](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-engineering-guidelines.html)

[System Prompts](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-bedrock.html)

[Amazon Comprehend](http://docs.aws.amazon.com/comprehend/latest/dg/what-is.html) - NLP tasks like sentiment analysis.

[AWS Trainium](https://aws.amazon.com/ai/machine-learning/trainium/)

[Amazon Elastic Kubernetes Service](https://aws.amazon.com/eks/)

[Amazon Guardrails](https://aws.amazon.com/bedrock/guardrails/) - Implement safeguards customized to your application requirements and responsible AI policies

[AWS Identity and Access Management (IAM)](https://aws.amazon.com/iam/) – Manage access to AWS resources.

[AWS Key Management Service (KMS)](https://aws.amazon.com/kms/) – Secure and manage cryptographic keys.

[AWS PrivateLink](https://aws.amazon.com/privatelink/) – Secure and private connectivity to AWS services.

[Amazon Macie](https://aws.amazon.com/macie/) – Data security and privacy service for data protection.

[AWS Security Hub](https://aws.amazon.com/security-hub/) – Unified view of security alerts and compliance status.

[AWS Web Application Firewall (WAF)](https://aws.amazon.com/waf/) – Understand how to protect web applications from common exploits.

[Amazon GuardDuty](https://aws.amazon.com/guardduty/) – Gain insights into threat detection services that continuously monitor for malicious activity.

[AWS Shield](https://aws.amazon.com/shield/) – Discover how to safeguard against DDoS attacks with AWS Shield's advanced protection.

[AWS Lake Formation](https://aws.amazon.com/lake-formation/) – Helps structure and organize AI training data securely.

[AWS Glue](https://aws.amazon.com/glue/) – Useful for cleaning and preparing data for AI models.
  
[AWS CloudTrail](https://aws.amazon.com/cloudtrail/) – Enables auditing by logging every action within AI systems.

[Amazon CloudWatch](https://aws.amazon.com/cloudwatch/) – Provides real-time monitoring of data pipelines and AI models.

[AWS Control Tower](https://aws.amazon.com/controltower/) – Assists in enforcing data residency compliance across AWS regions.

[AWS Cost Explorer](https://aws.amazon.com/aws-cost-management/aws-cost-explorer/) - Visualize, understand, and manage your AWS costs and usage over time

## General AI/ML on AWS

[AWS Machine Learning](https://aws.amazon.com/ai/machine-learning/)

[Generative AI on AWS](https://aws.amazon.com/ai/generative-ai/) - Information about AWS's generative AI offerings.

[Explore AWS Responsible AI resources](https://aws.amazon.com/ai/responsible-ai/)

[AWS Well-Architected](https://aws.amazon.com/architecture/well-architected/)

[AWS Compliance](https://aws.amazon.com/compliance/gdpr-center/#topic-0)

## Completetion Link

 [View my vert](...)

## AI Use Cases for AWS Services

| **AWS Service**     | **Use Case**                                                                 |
|----------------------|-------------------------------------------------------------------------------|
| Amazon Bedrock       | Generates marketing visuals and images based on textual descriptions.         |
| Amazon Comprehend    | Extracts key phrases, topics, and sentiments from text.                       |
| Amazon Lex           | Handles customer service interactions through intelligent chatbots.           |
| Amazon Rekognition   | Detects faces, extracts text, and moderates image and video content.          |
| Amazon Translate     | Translates content instantly between multiple languages.                      |
| AWS PrivateLink      | Keeps AI systems off the public internet for enhanced security.               |
| AWS Key Management Service (KMS) | Encrypts data handled by AI systems to protect sensitive information. |
| AWS Identity and Access Management (IAM) | Implements role-based access control to manage permissions for AI models. |

## AWS CLI setup for lab access

configure a profile (helpful to give a profile name)

```bash
aws configure --profile udacity-aws-lab-1
```

generate and apply access token

```bash
aws configure set aws_session_token "***" --profile udacity-aws-lab-1
```

command above will generate this

```bash
cat ~/.aws/credentials
```

add env vars to shell

```bash
export AWS_CONFIG_FILE=~/.aws/config
export AWS_SHARED_CREDENTIALS_FILE=~/.aws/credentials
```

check the profile is assigned

```bash
aws iam list-users --profile udacity-aws-lab-1
```

change region by profile

```bash
aws configure set region us-east-1 --profile udacity-aws-lab-1 
```

list users

```bash
aws iam list-users --profile udacity-aws-lab-1
```

preview config

```bash
aws configure list --profile udacity-aws-lab-1
```

test profile

```bash
AWS_PROFILE=udacity-aws-lab-1 aws sts get-caller-identity
AWS_PROFILE=udacity-aws-lab-1 aws bedrock list-foundation-models --region us-east-1

```

## Command Differences

aws bedrock vs. aws bedrock-runtime:

```bash
aws bedrock # Modify service configurations and enable new models/features.
aws bedrock-runtime # Invoke models directly and interact with them.
```

## Terraform

 is an open-source **infrastructure as code** (IaC) tool that allows you to define and provision infrastructure resources in a declarative manner. It helps automate the creation, modification, and destruction of infrastructure across various cloud providers (like AWS, Azure, GCP) and on-premises environments.

**Define Infrastructure** write configs in HashiCorp Configuration Language (HCL) or JSON to describe the desired state of your infrastructure. This includes defining resources like virtual machines, databases, networks, and more.

**Initialize Terraform** This command downloads the necessary provider plugins for the services you intend to use (e.g., AWS, Azure).

```bash
terraform init
```

**Plan Changes** This command analyzes your configuration files and compares them with the current state of your infrastructure (or an empty state if it's the first deployment). It then generates an execution plan, showing you exactly what changes Terraform will make to achieve the desired state, without actually applying them.

```bash
terraform plan
```

**Apply Changes** If you are satisfied with the plan use terraform apply. Terraform will then provision or modify the resources in your cloud or on-premises environment according to the execution plan. It interacts with the respective APIs of the providers to create, update, or delete resources.

```bash
terraform apply
```

**Destroy Infrastructure** When you no longer need the infrastructure use this to tear down all the resources defined in your configuration

```bash
terraform destroy
```

 . Terraform will prompt for confirmation before proceeding.
In essence, you declare what you want, and Terraform figures out how to make it
happen, providing a consistent and repeatable way to manage your infrastructure.

### Terraform Files

**terraform.tfstate** Terraform maintains a state file, typically named terraform.tfstate, which records the current state of your deployed infrastructure. This file is crucial for Terraform to understand what resources it manages and to perform future updates or deletions accurately.

**main.tf** is a conventional filename used to store the primary configuration for a module, especially the root module of a Terraform project. Terraform does not strictly require this specific filename and will process all .tf files in a directory, "main.tf" is widely adopted as a best practice to organize and identify the core resource definitions and module calls within a configuration.

## aws debugging

show me avaiable PostgresSQL versions by region

```bash
aws rds describe-db-engine-versions \
  --engine aurora-postgresql \
  --query "DBEngineVersions[].EngineVersion" \
  --output text \
  --region us-west-1
```
