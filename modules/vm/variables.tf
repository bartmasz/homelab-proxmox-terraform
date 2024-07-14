variable "inventory_path" {
  type = string
}
variable "proxmox_node" {
  type = string
}
variable "proxmox_gateway" {
  type = string
}
variable "vm_template_id" {
  type    = number
  default = 9001
}
variable "vm_template_cloud_init_username" {
  type = string
}
variable "vm_tags" {
  type = list(string)
}
variable "vm_definition" {
  type = list(object({
    vm_id            = number
    type             = string
    cpu_cores        = number
    cpu_limit        = number
    cpu_units        = number
    memory_dedicated = number
    hostname         = string
    ipv4_address     = string
    startup = object({
      order      = number
      up_delay   = number
      down_delay = number
    })
  }))
}
