module "sakabas-vpc-module" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 7.0"
  project_id   = var.project
  network_name = "sakabas"
  mtu          = 1460
  routing_mode = "REGIONAL"

  subnets = [
    {
      subnet_name   = "subnet-us-central-192"
      subnet_ip     = "192.168.1.0/24"
      subnet_region = var.region
    }
  ]
}
