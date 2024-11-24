
variable "proxmox_node" {
  type = string
}
variable "proxmox_gateway" {
  type = string
}
variable "ssh_key_path" {
  type = string
}
variable "template_file_id" {
  type = string
}
variable "operating_system_type" {
  type = string
}
variable "dns_servers" {
  type = list(string)
}
variable "dns_domain" {
  type = string
}
variable "ct_definition" {
  type = list(object({
    ct_id               = number
    hostname            = string
    cpu_cores           = number
    memory_dedicated_mb = number
    disk_size_gb        = number
    ipv4_address        = string
    bind_mount_points = list(object({
      volume = string
      path   = string
    }))
    features = object({
      nesting = bool
    })
    startup = object({
      order      = number
      up_delay   = number
      down_delay = number
    })
  }))
}
