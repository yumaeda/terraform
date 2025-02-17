resource "cloudflare_workers_script" "atelier_de_lumiere_workers_script" {
  account_id  = var.cloudflare_account_id
  script_name = "atelier-de-lumiere-com"
  content     = file("./worker.js")
}
