module "storage" {
  source = "./env/us-east-1/storage"
}

module "imported" {
  source = "./to-import"
}
