# terraform
Contains Terraform configuration files

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

## Setting the Cache-Control header for GCS bucket
- By default, Cloud Storage set max-age to `3600`.
- Instructs GCS not to cache contents, but instructs CDN to cache contents for 10 days.
```zsh
gsutil setmeta -r -h "Cache-Control: no-store, max-age=864000" gs://ramen-mania.net
```

## Upload images
```zsh
gsutil cp *.webp gs://ramen-mania.net/images/
```

## Get detail of index.html
```zsh
gsutil ls -L gs://ramen-mania.net/index.html
```

## Destroy
- GCS buckets will not be removed since they have files.
```zsh
terraform destroy
```

## References
- https://cloud.google.com/docs/terraform/resource-management/store-state
- https://medium.com/swlh/setup-a-static-website-cdn-with-terraform-on-gcp-23c6937382c6
