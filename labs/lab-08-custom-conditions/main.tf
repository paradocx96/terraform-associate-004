terraform {
  required_version = ">= 1.9.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

variable "port" {
  type = number

  validation {
    condition     = var.port >= 1024 && var.port <= 65535
    error_message = "Port must be between 1024 and 65535."
  }
}

resource "local_file" "cfg" {
  filename = "${path.module}/cfg.txt"
  content  = "port=${var.port}\n"

  lifecycle {
    precondition {
      condition     = var.port != 8080
      error_message = "Port 8080 is reserved."
    }

    postcondition {
      condition     = self.content != ""
      error_message = "Generated content must not be empty."
    }
  }
}

check "port_is_unprivileged" {
  assert {
    condition     = var.port > 1023
    error_message = "Port is in the privileged range."
  }
}

output "cfg_path" {
  value = local_file.cfg.filename
}
