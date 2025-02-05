# terraform
Contains Terraform configuration files

## Preparation
### Install Terraform
- Follow [instructions](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-terraform) in the HashiCorp Developer website

### Export project ID
```zsh
export GOOGLE_PROJECT={PROJECT_ID}
```
### Login to GCP
```zsh
gcloud auth application-default login --project $GOOGLE_PROJECT
```
### Configure Terraform to store state in Cloud Storage bucket
```zsh
terraform init
```
### Enable services
```zsh
gcloud services enable iap.googleapis.com container.googleapis.com
```
```zsh
gcloud services list
```

&nbsp;

## Commands
### Plan
```zsh
terraform plan
```
### Apply
```zsh
terraform apply
```
#### Apply only the specified resource
```zsh
terraform apply -target=$RESOURCE_TYPE.$RESOURCE_NAME
```
### Destroy
```zsh
terraform destroy
```
#### Destroy only the specified resource
```zsh
terraform destroy -target={RESOURCE_TYPE}.{NAME}
```

&nbsp;

## Testing Public NAT
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
- Get an unique identifier of the workload identity pool
```zsh
gcloud iam workload-identity-pools describe "github-pool-3" --location="global" --format="value(name)"
```
- Get an unique identifier of the provider
```zsh
gcloud iam workload-identity-pools providers describe "github-provider" --location="global" --workload-identity-pool="github-pool-3" --format="
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
