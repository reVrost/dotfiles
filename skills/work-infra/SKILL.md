---
name: work-infra
description: Stake GCP infrastructure automation via GitHub Actions workflows. Use when creating secrets, attaching services to PubSub/storage, creating Cloud Run manifests, Redis, schedulers, or any GCP infrastructure task in stake-global/gcp.infrastructure repo. Triggers on "create secret", "infra", "gcp infrastructure", "pubsub", "cloud run manifest", "redis", "scheduler".
---

# Work Infrastructure

Automate GCP infrastructure tasks via GitHub Actions workflows in `stake-global/gcp.infrastructure`.

## Quick Reference

| Task | Workflow Name | Key Inputs |
|------|--------------|------------|
| Create secrets | Create Secrets In Service Folders For All Environments | serviceName, secretName |
| Attach to PubSub | Attach service to Pub/Sub topic as publisher from a project | serviceName, topicName, projectName |
| Attach to secret | Attach Service to Secret in Secret Project | serviceName, secretName |
| Attach to storage | Attach Service to Storage Bucket | serviceName, bucketName |
| Create Cloud Run | Create Manifests for New Cloud Run | serviceName, ... |
| Create PubSub topic | Create Pub/Sub Topic In Project Folder | topicName, projectName |
| Create Redis | Create Redis | serviceName |
| Create scheduler (HTTP) | Create Cloud Scheduler In Project Folder (HTTP Target) | schedulerName, ... |
| Create scheduler (PubSub) | Create Cloud Scheduler In Project Folder (Pub/Sub Target) | schedulerName, ... |
| Create storage bucket | Create Storage Buckets | bucketName, ... |

## Creating Secrets

To create secrets for a service across all environments (UAT, Pre-Prod, Prod):

```bash
gh workflow run "Create Secrets In Service Folders For All Environments" \
  --repo stake-global/gcp.infrastructure \
  -f serviceName="<service-name>" \
  -f secretName="<secret-name>"
```

**Inputs:**
- `serviceName`: Service name (e.g., `fn-execute-order-cmd-sub`, `svc-test-instrument`)
- `secretName`: Secret name WITHOUT prefix (e.g., `alpaca-api-key`, NOT `sec-u-hs-secrets-alpaca-api-key`)

The workflow creates secrets in all environments with naming pattern:
- UAT: `sec-u-hs-secrets-<secretName>`
- Pre-Prod: `sec-n-hs-secrets-<secretName>`
- Prod: `sec-p-hs-secrets-<secretName>`

**Example:** Create Alpaca API credentials for fn-execute-order-cmd-sub:
```bash
gh workflow run "Create Secrets In Service Folders For All Environments" \
  --repo stake-global/gcp.infrastructure \
  -f serviceName="fn-execute-order-cmd-sub" \
  -f secretName="alpaca-api-key"

gh workflow run "Create Secrets In Service Folders For All Environments" \
  --repo stake-global/gcp.infrastructure \
  -f serviceName="fn-execute-order-cmd-sub" \
  -f secretName="alpaca-api-secret"
```

## Attaching Service to Secrets (IAM)

After creating secrets, grant the service account access to read them:

```bash
gh workflow run "Attach Service to Secret in Secret Project" \
  --repo stake-global/gcp.infrastructure \
  -f secretName="<secret-name>" \
  -f serviceName="<service-name>" \
  -f includeUAT=true \
  -f includePREPROD=false \
  -f includePROD=true \
  -f includeDEV=false \
  -f includeCOMMON=false \
  -f isCloudRunFunction=<true|false>
```

**Inputs:**
- `secretName`: **IMPORTANT: Use the EXACT same name you used when creating the secret (e.g., `alpaca-api-key`). Do NOT add any prefix like `hs-secrets-` - the workflow adds prefixes automatically. Adding extra prefixes causes double-prefixing like `sec-u-hs-secrets-hs-secrets-alpaca-api-key`.**
- `serviceName`: Service name (e.g., `fn-execute-order-cmd-sub`, `svc-crypto-hedger`)
- `isCloudRunFunction`: Set `true` for Cloud Run functions (uses `-cr-runtime` SA suffix)
- `include*`: Select which environments to apply

**Example:** Attach Alpaca secrets to fn-execute-order-cmd-sub:
```bash
gh workflow run "Attach Service to Secret in Secret Project" \
  --repo stake-global/gcp.infrastructure \
  -f secretName="alpaca-api-key" \
  -f serviceName="fn-execute-order-cmd-sub" \
  -f includeUAT=true \
  -f includePREPROD=false \
  -f includePROD=true \
  -f includeDEV=false \
  -f includeCOMMON=false \
  -f isCloudRunFunction=true

gh workflow run "Attach Service to Secret in Secret Project" \
  --repo stake-global/gcp.infrastructure \
  -f secretName="alpaca-api-secret" \
  -f serviceName="fn-execute-order-cmd-sub" \
  -f includeUAT=true \
  -f includePREPROD=false \
  -f includePROD=true \
  -f includeDEV=false \
  -f includeCOMMON=false \
  -f isCloudRunFunction=true
```

## Running Any Workflow

List all available workflows:
```bash
gh workflow list --repo stake-global/gcp.infrastructure
```

View workflow inputs:
```bash
gh workflow view "<workflow-name>" --repo stake-global/gcp.infrastructure --yaml | head -30
```

Run a workflow:
```bash
gh workflow run "<workflow-name>" --repo stake-global/gcp.infrastructure -f input1="value1" -f input2="value2"
```

Check workflow run status:
```bash
gh run list --repo stake-global/gcp.infrastructure --workflow="<workflow-name>" --limit 5
```

## Environment Reference

| Env | Code | Project ID (Trading) | Project ID (Secrets) |
|-----|------|---------------------|---------------------|
| UAT | u | prj-u-hs-trading | 593965290648 |
| Pre-Prod | n | prj-n-hs-trading | 575509099362 |
| Prod | p | prj-p-hs-trading | 288337744455 |
