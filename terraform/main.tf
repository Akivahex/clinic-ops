// 1. BUSCAR LA CLAVE SSH EXISTENTE
// Usamos un 'data source' porque la clave ya existe en Hetzner.
// No le pedimos a Terraform que la cree, solo que la encuentre por su nombre.
data "hcloud_ssh_key" "default" {
  name = var.ssh_key_name
}

// 2. CREAR EL FIREWALL DE SEGURIDAD
// Este recurso crea un nuevo firewall desde cero.
// La política es "denegar todo por defecto" y solo permitir lo que definimos.
resource "hcloud_firewall" "web_server_fw" {
  name = "${var.server_name}-fw" // Un nombre dinámico para el firewall.

  // Regla 1: Permitir acceso administrativo (SSH)
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = ["84.119.109.79/32"] // ¡ACCIÓN CRÍTICA! Reemplaza esto.
  }

  // Regla 2: Permitir 'ping' para diagnósticos de red desde cualquier lugar.
  rule {
    direction  = "in"
    protocol   = "icmp"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
  // Regla 3: Permitir tráfico web (HTTP) desde cualquier lugar.
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "80"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
}





// 3. CREAR EL SERVIDOR
// Este recurso crea el servidor y conecta los otros componentes.
resource "hcloud_server" "main" {
  name         = var.server_name
  server_type  = var.server_type
  image        = var.image_name
  location     = var.location
  ssh_keys     = [data.hcloud_ssh_key.default.id] // Asocia la clave SSH que encontramos.
  firewall_ids = [hcloud_firewall.web_server_fw.id] // Asocia el firewall que creamos.

  // Las etiquetas son buenas prácticas para organizar recursos.
  labels = {
    "managed_by" = "terraform",
    "project"    = "terapeuta-guatemala"
  }
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/../ansible/inventory/inventory.tpl", {
    server_ip = hcloud_server.main.ipv4_address
  })
  filename = "${path.module}/../ansible/inventory/inventory.ini"
}
