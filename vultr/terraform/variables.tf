# variable "flatcar_release_channel" {
#   type    = string
#   default = "stable"
# }

# variable "flatcar_architecture" {
#   type    = string
#   default = "amd64"
# }

# variable "flatcar_version" {
#   type    = string
#   default = "current"
# }

variable "bridge_email" {
  sensitive = true
  type    = string
}

variable "tailscale_auth_key" {
  sensitive = true
  type    = string
}
