variable "bridge_count" {
  type    = number
  default = 1
}

variable "bridge_name_prefix" {
  sensitive = true
  type      = string
}

variable "bridge_email" {
  sensitive = true
  type      = string
}

variable "bridge_or_port" {
  type    = number
  default = 12800
}

variable "bridge_pt_port" {
  type    = number
  default = 12801
}

variable "tailscale_auth_key" {
  sensitive = true
  type      = string
}
