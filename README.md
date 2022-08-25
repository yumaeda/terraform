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

## Upload images
```zsh
gsutil cp *.webp gs://ramen-mania.net/images/
```

## Invalidate Cloud CDN cache
```zsh
gcloud compute url-maps invalidate-cdn-cache website-url-map --path "/*" --async
```

## Destroy
- GCS buckets will not be removed since they have files.
```zsh
terraform destroy
```

## References
- https://cloud.google.com/docs/terraform/resource-management/store-state
- https://medium.com/swlh/setup-a-static-website-cdn-with-terraform-on-gcp-23c6937382c6
