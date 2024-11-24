resource "proxmox_virtual_environment_container" "container" {
  for_each = { for ct in var.ct_definition :
    "${ct.ct_id}-${ct.hostname}" => ct
  }

  node_name = var.proxmox_node
  vm_id     = each.value.ct_id

  initialization {
    hostname = each.value.hostname

    ip_config {
      ipv4 {
        address = each.value.ipv4_address
        gateway = var.proxmox_gateway
      }
    }

    dns {
      servers = var.dns_servers
      domain  = var.dns_domain
    }

    user_account {
      keys = [file(var.ssh_key_path)]
    }
  }

  cpu {
    cores = each.value.cpu_cores
  }

  memory {
    dedicated = each.value.memory_dedicated_mb
  }

  console {
    type = "shell"
  }

  network_interface {
    name = "vmbr0"
  }

  operating_system {
    template_file_id = var.template_file_id
    type             = var.operating_system_type
  }

  disk {
    datastore_id = "local-lvm"
    size         = each.value.disk_size_gb
  }

  dynamic "mount_point" {
    # bind mount, *requires* root@pam authentication
    for_each = each.value.bind_mount_points
    content {
      volume = mount_point.value.volume
      path   = mount_point.value.path
    }
  }

  # mount_point {
  #   # volume mount, a new volume will be created by PVE
  #   volume = "local-lvm"
  #   size   = "10G"
  #   path   = "/mnt/volume"
  # }

  features {
    nesting = each.value.features.nesting
  }

  startup {
    order      = each.value.startup.order
    up_delay   = each.value.startup.up_delay
    down_delay = each.value.startup.down_delay
  }

  lifecycle {
    create_before_destroy = false
  }
}

