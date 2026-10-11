terraform {
  required_version = ">= 1.9.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

module "alice" {
  source = "./modules/greeting"

  name       = "alice"
  output_dir = path.module
}

module "team" {
  source   = "./modules/greeting"
  for_each = toset(["bob", "carol"])

  name       = each.key
  output_dir = path.module
}

output "alice_file" {
  value = module.alice.file_path
}

output "team_files" {
  value = { for k, m in module.team : k => m.file_path }
}
