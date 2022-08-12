# terraform-demo
Terraform demo

## Setup
```zsh
brew install terraform
```

## Login
```zsh
gcloud auth application-default login --project $PROJECT_ID
```

## Configure Terraform to store state in Cloud Storage bucket
```zsh
export GOOGLE_PROJECT=$PROJECT_ID
terraform init
terraform apply
```

## References
- https://cloud.google.com/docs/terraform/resource-management/store-state
