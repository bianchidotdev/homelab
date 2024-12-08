resource "vultr_instance" "bridges" {
  count = var.bridge_count
  # high performance amd 1vcpu 1gb ram
  plan = "vhp-1c-1gb-amd"
  # frankfurt region
  region   = "fra"
  os_id    = data.vultr_os.flatcar-stable.id
  label    = "bridge-1"
  hostname = "${var.bridge_name_prefix}${count.index + 1}"

  firewall_group_id = vultr_firewall_group.bridges.id

  user_data = data.ct_config.bridges[count.index].rendered

  tags = [
    "bridge",
    "terraform",
  ]
}

resource "vultr_firewall_group" "bridges" {
  description = "Allow inbound traffic for bridges"
}

resource "vultr_firewall_rule" "allow_or_port" {
  firewall_group_id = vultr_firewall_group.bridges.id
  protocol          = "tcp"
  ip_type           = "v4"
  subnet            = "0.0.0.0"
  subnet_size       = 0
  port              = var.bridge_or_port
}

resource "vultr_firewall_rule" "allow_pt_port" {
  firewall_group_id = vultr_firewall_group.bridges.id
  protocol          = "tcp"
  ip_type           = "v4"
  subnet            = "0.0.0.0"
  subnet_size       = 0
  port              = var.bridge_pt_port
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
      or_port     = var.bridge_or_port
      pt_port     = var.bridge_pt_port
    }),
    templatefile("../tailscale.yaml.tftpl", {
      tailscale_auth_key = var.tailscale_auth_key
    }),
  ]
}
