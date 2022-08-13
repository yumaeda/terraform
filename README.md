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
terraform plan
```

## If the plan looks good
```zsh
terraform apply
```

## Update index.html
```zsh
gsutil cp index.html gs://ramen-mania.net/
```

## References
- https://cloud.google.com/docs/terraform/resource-management/store-state
- https://github.com/gruntwork-io/terraform-google-static-assets/tree/master/modules/cloud-storage-static-website