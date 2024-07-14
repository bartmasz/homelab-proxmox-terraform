
resource "proxmox_virtual_environment_vm" "vm" {
  for_each = { for vm in var.vm_definition :
    "${vm.vm_id}-${vm.hostname}" => vm
  }
  node_name = var.proxmox_node
  vm_id     = each.value.vm_id
  name      = each.value.hostname
  tags      = concat(var.vm_tags, [each.value.type])

  started = true
  on_boot = true
  startup {
    order      = each.value.startup.order
    up_delay   = each.value.startup.up_delay
    down_delay = each.value.startup.down_delay
  }

  clone {
    vm_id   = var.vm_template_id
    retries = 1
  }

  boot_order = ["scsi0"]

  memory {
    dedicated = each.value.memory_dedicated
  }

  cpu {
    type  = "host"
    cores = each.value.cpu_cores
    limit = each.value.cpu_limit
    units = each.value.cpu_units
  }

  network_device {
    bridge  = "vmbr0"
    enabled = true
  }

  initialization {
    ip_config {
      ipv4 {
        address = each.value.ipv4_address
        gateway = var.proxmox_gateway
      }
    }
  }

  lifecycle {
    ignore_changes = [
      # List of attributes to ignore
      initialization,
    ]
  }
}
