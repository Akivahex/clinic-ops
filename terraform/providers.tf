terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.52" // Fijamos la versión para evitar que futuras actualizaciones rompan nuestro código.
    }
  }
}

// Aquí configuramos el proveedor, diciéndole que use el token
// que definimos en nuestras variables.
provider "hcloud" {
  token = var.hcloud_token
}
