resource "cloudflare_dns_record" "atelier_de_lumiere_cname" {
  zone_id  = var.cloudflare_zone_id
  name     = "@"
  content  = "${google_storage_bucket.atelier_de_lumiere_com.name}.storage.googleapis.com"
  type     = "CNAME"
  ttl      = 1
  proxied  = true
}
