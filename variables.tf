variable "project" {
  description = "The project ID to host the site in."
  type        = string
}

variable "website_domain_name" {
  description = "The name of the website and the Cloud Storage bucket to create (e.g. static.foo.com)."
  type        = string
}

variable "region" {
    description = "Google Cloud region"
    type        = string
    default     = "us-central1"
}

variable "zone" {
    description = "Google Cloud zone"
    type        = string
    default     = "us-central1-a"
}

variable "vpc_name" {
    description = "Google VPN"
    type        = string
    default     = "default"
}
