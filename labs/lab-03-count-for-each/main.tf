terraform {
  required_version = ">= 1.9.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

variable "users" {
  type = map(object({
    role = string
  }))
  default = {
    alice = { role = "admin" }
    bob   = { role = "dev" }
  }
}

variable "names" {
  type    = list(string)
  default = ["one", "two", "three"]
}

# count: index-based
resource "local_file" "numbered" {
  count    = length(var.names)
  filename = "${path.module}/out/count-${count.index}-${var.names[count.index]}.txt"
  content  = "item ${count.index}: ${var.names[count.index]}\n"
}

# for_each: key-based (map)
resource "local_file" "user" {
  for_each = var.users
  filename = "${path.module}/out/user-${each.key}.txt"
  content  = "user=${each.key} role=${each.value.role}\n"
}

# for_each: set of strings (list converted with toset)
resource "local_file" "from_set" {
  for_each = toset(var.names)
  filename = "${path.module}/out/set-${each.key}.txt"
  content  = "set item ${each.key}\n"
}

output "roles_upper" {
  value = { for k, v in var.users : k => upper(v.role) }
}

output "admins" {
  value = [for k, v in var.users : k if v.role == "admin"]
}

output "count_files" {
  value = local_file.numbered[*].filename
}
