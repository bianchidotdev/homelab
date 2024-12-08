output "bridges_ipv4" {
  value = vultr_instance.bridges[*].main_ip
}
