variable "project" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "Google Cloud region"
  type        = string
  default     = "asia-northeast1"
}

variable "cloudflare_email" {
  description = "Cloudflare account email"
  type        = string
  default     = "yumaeda@gmail.com"
}

variable "cloudflare_api_key" {
  description = "Cloudflare API key"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
}
