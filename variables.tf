variable "app_service_plan_id" {
  type = string
  default = ""
}

variable "app_settings" {
  type = map(string)
  default = {}
}

variable "auth_settings" {
  type = object({
    name = optional(string)
  })
  default = {}
}

variable "auth_settings_v2" {
  type = object({
    name = optional(string)
  })
  default = {}
}

variable "backup" {
  type = object({
    name = optional(string)
  })
  default = {}
}

variable "builtin_logging_enabled" {
  type = bool
  default = false
}

variable "client_certificate_enabled" {
  type = bool
  default = false
}

variable "client_certificate_mode" {
  type = string
  default = "Ignore"
}

variable "client_certificate_exclusion_paths" {
  type = string
  default = ""
}

variable "connection_string" {
  type = string
  default = ""
}

variable "content_share_force_disabled" {
  type = bool
  default = false
}

variable "daily_memory_time_quota" {
  type = number
  default = 0
}

variable "enabled" {
  type = bool
  default = true
}

variable "environment" {
  type = string
}

variable "ftp_publish_basic_authentication" {
  type = bool
  default = true
}

variable "functions_extension_version" {
  type = string
  default = "~4"
}

variable "https_only" {
  type = bool
  default = true
}

variable "ip_restrictions" {
  type = list(object({
    action = optional(string, "Allow")
    name = string
    ip_address = string
    priority = string
  }))
  default = [ 
    {
      action     = "Allow"
      name       = "Github Enterprise Hooks"
      ip_address = "192.30.252.0/22"
      priority   = 100
    },
    {
      action     = "Allow"
      name       = "Github Enterprise Hooks"
      ip_address = "185.199.108.0/22"
      priority   = 110
    },
    {
      action     = "Allow"
      name       = "Github Enterprise Hooks"
      ip_address = "140.82.112.0/20"
      priority   = 120
    },
    {
      action     = "Allow"
      name       = "Github Enterprise Hooks"
      ip_address = "143.55.64.0/20"
      priority   = 130
    },
    {
      action     = "Allow"
      name       = "Github Enterprise Hooks"
      ip_address = "2a0a:a440::/29"
      priority   = 140
    },
    {
      action     = "Allow"
      name       = "Github Enterprise Hooks"
      ip_address = "2606:50c0::/32"
      priority   = 150
    }
  ]
}

variable "key_vault_secret_id" {
  type = string
  default = ""
}

variable "location" {
  type = string
  default = "eastus"
}

variable "private_dns_zone_group_name" {
  type = string
  default = "default"
}

variable "private_dns_zone_ids" {
  type = list(string)
  default = [ "/subscriptions/56bdaed4-70cf-4a28-8fb8-0efc135bb29f/resourceGroups/rg-azuredns-prd-01/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net" ]
}

variable "private_endpoint_subnet_id" {
  type = string
}

variable "public_network_access_enabled" {
  type = bool
  default = false
}

variable "resource_group_name" {
  type = string
}

variable "solution_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "storage_account_access_key" {
  type = string
  default = ""
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "vnet_integration_subnet_id" {
  type = string
}
