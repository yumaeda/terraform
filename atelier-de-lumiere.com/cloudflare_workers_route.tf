resource "cloudflare_workers_route" "atelier_de_lumiere_workers_route" {
  zone_id = var.cloudflare_zone_id
  pattern = "atelier-de-lumiere.com/*"
  script  = cloudflare_workers_script.atelier_de_lumiere_workers_script.script_name
}
