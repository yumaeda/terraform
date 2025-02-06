# Setup

## Use gcloud credentials for Terraform
```zsh
gcloud auth application-default login
```

## Set the current GCP project
```zsh
gcloud config set project ${PROJECT_ID}
```

## Initialize Terraform
```zsh
terraform init
```

## Execute dry-run for the Terraform configuration change
```zsh
terraform plan
```

## Apply the Terraform configuration change
```zsh
terraform apply
```

# Reference
- https://community.cloudflare.com/t/google-cloud-storage-private-access/389280

