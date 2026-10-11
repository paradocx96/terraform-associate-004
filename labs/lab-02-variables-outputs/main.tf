terraform {
  required_version = ">= 1.9.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment environment"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be dev, staging or prod."
  }
}

variable "owner" {
  type    = string
  default = "student"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "api_token" {
  type        = string
  sensitive   = true
  description = "Pass with TF_VAR_api_token; never hard-code secrets"
}

locals {
  name_prefix = "${var.owner}-${var.environment}"
  common_tags = merge(
    {
      environment = var.environment
      owner       = var.owner
    },
    var.tags
  )
}

resource "local_file" "config" {
  filename = "${path.module}/${local.name_prefix}.json"
  content = jsonencode({
    tags         = local.common_tags
    token_length = length(var.api_token)
  })
}

output "config_file" {
  value = local_file.config.filename
}

output "tags" {
  value = local.common_tags
}

output "token" {
  value     = var.api_token
  sensitive = true
}
