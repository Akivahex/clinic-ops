output "server_ipv4_address" {
  description = "La dirección IPv4 pública del servidor para conectarnos por SSH."
  value       = hcloud_server.main.ipv4_address
}
