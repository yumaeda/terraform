variable "project" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "region" {
    description = "Google Cloud region"
    type        = string
    default     = "asia-northeast1"
}

variable "cloudflare_api_key" {
    description = "Cloudflare API key"
    type        = string
}
