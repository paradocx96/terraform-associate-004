terraform {
  required_version = ">= 1.9.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

resource "random_pet" "name" {
  length = 2
}

resource "local_file" "hello" {
  filename = "${path.module}/hello-${random_pet.name.id}.txt"
  content  = "Hello from Terraform, ${random_pet.name.id}!\n"
}

output "file_path" {
  value = local_file.hello.filename
}
