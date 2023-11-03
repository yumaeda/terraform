resource "google_project_service" "project" {
    project                    = var.project
    service                    = "iamcredentials.googleapis.com"
    disable_dependent_services = true
}

resource "google_service_account" "github" {
    project      = var.project
    account_id   = "github"
    display_name = "GitHub Service Account"
}

resource "google_iam_workload_identity_pool" "github_pool" {
    project                   = var.project
    workload_identity_pool_id = "github-pool"
    display_name              = "GitHub Pool"
    description               = "Workload Identity Pool for GitHub Action Roles"
}

resource "google_iam_workload_identity_pool_provider" "github_provider" {
    project                            = var.project
    workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
    workload_identity_pool_provider_id = "github-provider"
    display_name                       = "GitHub Pool Provider"
    description                        = "Workload Identity Pool Provider for GitHub Action Roles"
    attribute_mapping = {
        "google.subject"       = "assertion.sub"
        "attribute.repository" = "assertion.repository"
    }
    oidc {
        issuer_uri = "https://token.actions.githubusercontent.com"
    }
}

resource "google_service_account_iam_member" "github_workload_identity_nginx_gcs_proxy" {
    service_account_id = google_service_account.github.id
    role               = "roles/iam.workloadIdentityUser"
    member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.repository/yumaeda/nginx-gcs-proxy"
}

resource "google_service_account_iam_member" "github_workload_identity_sakaba_front" {
    service_account_id = google_service_account.github.id
    role               = "roles/iam.workloadIdentityUser"
    member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.repository/yumaeda/sakaba-front"
}

resource "google_project_iam_member" "artifact_registry_admin" {
    project = var.project
    role    = "roles/artifactregistry.admin"
    member  = "serviceAccount:${google_service_account.github.email}"
}

resource "google_project_iam_member" "storage_admin" {
    project = var.project
    role    = "roles/storage.admin"
    member  = "serviceAccount:${google_service_account.github.email}"
}