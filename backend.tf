terraform {
    backend "gcs" {
        bucket = "bucket-tfstate-1cf106510487adf1"
        prefix = "terraform/state"
    }
}
