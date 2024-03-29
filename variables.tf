variable "project" {
  description = "The project ID to host the site in."
  type        = string
}

variable "region" {
    description = "Google Cloud region"
    type        = string
    default     = "asia-northeast1"
}

variable "zone" {
    description = "Google Cloud zone"
    type        = string
    default     = "asia-northeast1-b"
}

variable "vpc_name" {
    description = "Google VPN"
    type        = string
    default     = "default"
}
