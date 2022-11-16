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

## Set cache-control meta
- By default, Cloud Storage set max-age to `3600`.
- Use `Cache-Control: no-store` to indicate that the file must not be cached for subsequent requests.
```zsh
gsutil setmeta -h "Cache-control:public, max-age=60" gs://ramen-mania.net/index.html 
```

## Disable cache for all the files
```zsh
gsutil setmeta -r -h "Cache-control:no-cache" gs://ramen-mania.net
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
