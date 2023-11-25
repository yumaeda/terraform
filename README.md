# terraform
Contains Terraform configuration files

## Preparation
### Enable APIs
```zsh
gcloud services enable iap.googleapis.com
```
```zsh
gcloud services enable container.googleapis.com
```
### Install Terraform
```zsh
brew install terraform
```
### Login to GCP
```zsh
gcloud auth application-default login --project $PROJECT_ID
```
### Configure Terraform to store state in Cloud Storage bucket
```zsh
export GOOGLE_PROJECT=$PROJECT_ID
terraform init
```

&nbsp;

## Plan
```zsh
terraform plan
```

&nbsp;

## Apply
```zsh
terraform apply
```
### Apply the specified resource
```zsh
terraform apply -target=$RESOURCE_TYPE.$RESOURCE_NAME
```

&nbsp;

## Destroy
- GCS buckets will not be removed since they have files.
```zsh
terraform destroy
```
### Destroy the specified resource
```zsh
terraform destroy -target={RESOURCE_TYPE}.{NAME}
```

&nbsp;

## Confirm that k8s node can reach the internet
### Get a list of k8s nodes
```zsh
gcloud compute instances list
```
### Connect to the node
```zsh
gcloud compute ssh $NODE_NAME \
    --zone us-central1-a \
    --tunnel-through-iap
```
### Find the process ID of the `kube-dns` container
```zsh
pgrep '^kube-dns$'
```
### Access the container
```zsh
sudo nsenter --target $PROCESS_ID --net /bin/bash
```
### From `kube-dns`, attempt to connect to the internet
```zsh
curl example.com
```

&nbsp;

## Misc
- Get a list of enabled services
```zsh
gcloud services list
```
- Get an unique identifier of the workload identity pool
```zsh
gcloud iam workload-identity-pools describe "github-pool" --location="global" --format="value(name)"
```
- Get an unique identifier of the provider
```zsh
gcloud iam workload-identity-pools providers describe "github-provider" --location="global" --workload-identity-pool="github-pool" --format="
value(name)"
```
- Print out the permissions
```zsh
gcloud projects get-iam-policy $PROJECT_ID --flatten="bindings[].members"   
```

&nbsp;

## Deploy ramen-mania.net
### Update index.html
```zsh
gsutil cp index.html gs://ramen-mania.net/
```
### Setting the Cache-Control header for GCS bucket
- By default, Cloud Storage set max-age to `3600`.
- Instructs GCS not to cache contents, but instructs CDN to cache contents for 10 days.
```zsh
gsutil setmeta -r -h "Cache-Control: no-store, max-age=864000" gs://ramen-mania.net
```
### Upload images
```zsh
gsutil cp *.webp gs://ramen-mania.net/images/
```
### Get detail of index.html
```zsh
gsutil ls -L gs://ramen-mania.net/index.html
```

&nbsp;

## References
- https://cloud.google.com/nat/docs/gke-example#terraform_3
- https://gist.github.com/palewire/12c4b2b974ef735d22da7493cf7f4d37
- https://cloud.google.com/docs/terraform/resource-management/store-state
- https://medium.com/swlh/setup-a-static-website-cdn-with-terraform-on-gcp-23c6937382c6
- https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
- https://medium.com/google-cloud/terraform-on-google-cloud-v1-2-deploying-postgresql-with-github-actions-e7009cb04d22
