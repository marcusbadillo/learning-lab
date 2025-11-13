# demo-1

```bash
```bash
AWS_PROFILE=udacity-aws-lab-1 \
aws bedrock-runtime invoke-model \
  --region us-east-1 \
  --model-id anthropic.claude-3-sonnet-20240229-v1:0 \
  --body fileb://payload.json \
  --content-type "application/json" \
  --accept "application/json" \
  --cli-binary-format raw-in-base64-out \
  response.json
```
