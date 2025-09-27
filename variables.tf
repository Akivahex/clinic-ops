variable "hcloud_token" {
  description = "El token de la API de Hetzner Cloud. Es sensible y no se mostrará en la consola."
  type        = string
  sensitive   = true // Esto le dice a Terraform que oculte este valor en los logs.
}

variable "server_name" {
  description = "El nombre que le daremos a nuestro servidor."
  type        = string
  default     = "web-server-01" // Un valor por defecto si no especificamos otro.
}

variable "server_type" {
  description = "El tipo de servidor (potencia, RAM, etc.). 'cpx11' es un buen punto de partida."
  type        = string
  default     = "cpx11"
}

variable "image_name" {
  description = "La imagen del sistema operativo que instalaremos."
  type        = string
  default     = "ubuntu-24.04"
}

variable "location" {
  description = "La ubicación del centro de datos de Hetzner (ej. nbg1 para Nuremberg)."
  type        = string
  default     = "nbg1"
}

variable "ssh_key_name" {
  description = "El nombre exacto de la clave SSH que subiste a la consola de Hetzner."
  type        = string
  // No ponemos un 'default' aquí para forzar que se defina explícitamente.
}
