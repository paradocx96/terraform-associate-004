terraform {
  required_version = ">= 1.9.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

resource "local_file" "a" {
  filename = "${path.module}/out/a.txt"
  content  = "a\n"
}

resource "local_file" "b" {
  filename = "${path.module}/out/b.txt"
  content  = "b\n"
}
