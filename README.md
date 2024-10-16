# aurora-cluster-tag-inheritance

## Quick Start

```bash
cd terraform
# update your information (terraform backend, cloud provider)
tf init
tf apply --auto-approve
```

## Description

- Aurora cluster does not inherit tags from the cluster when creating read replicas.
- So I created this project.
- I hope my code is not used. I hope AWS adds new features.

## How it works

- eventbridge rule watching cloudtrail event
  - `CreateDBInstance`
- eventbridge trigger lambda function
- lambda function update replicas tag
  - extract cluster information from event message
  - lambda function update read replicas's tag
