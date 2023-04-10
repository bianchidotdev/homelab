client {
  enabled = true
  network_interface = "enp6s0"
}
server {
  enabled = true
  bootstrap_expect = 1
}
datacenter = "bonk1"
data_dir = "/opt/nomad"
name =  "bonkynomad"
