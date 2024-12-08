resource "vultr_instance" "bridges" {
  count = var.bridge_count
  # high performance amd 1vcpu 1gb ram
  plan = "vhp-1c-1gb-amd"
  # frankfurt region
  region    = "fra"
  label     = "bridge-1"
  os_id     = data.vultr_os.flatcar-stable.id
  user_data = data.ct_config.bridges[count.index].rendered

  hostname = "${var.bridge_name_prefix}${count.index + 1}"

  tags = [
    "bridge",
    "terraform",
  ]
}

# butane -> ignition resource
data "ct_config" "bridges" {
  count        = var.bridge_count
  content      = file("../system.yaml")
  strict       = true
  pretty_print = false

  snippets = [
    templatefile("../bridge.yaml.tftpl", {
      bridge_name = "${var.bridge_name_prefix}${count.index + 1}"
      email       = var.bridge_email
    }),
    templatefile("../tailscale.yaml.tftpl", {
      tailscale_auth_key = var.tailscale_auth_key
    }),
  ]
}
