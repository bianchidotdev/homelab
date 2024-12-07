resource "vultr_instance" "bridge_1" {
  # high performance amd 1vcpu 1gb ram
  plan = "vhp-1c-1gb-amd"
  # frankfurt region
  region    = "fra"
  label = "bridge-1"
  os_id = data.vultr_os.flatcar-stable.id
  user_data = data.ct_config.bridge.rendered

  hostname = "bridge-1"
}

# butane -> ignition resource
data "ct_config" "bridge" {
  content      = templatefile("../bridge.yaml.tftpl", {
    email = var.bridge_email
    tailscale_auth_key = var.tailscale_auth_key
  })
  strict       = true
  pretty_print = false

  snippets = []
}
