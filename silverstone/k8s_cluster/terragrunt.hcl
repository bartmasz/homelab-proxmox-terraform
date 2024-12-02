include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "node" {
  path   = find_in_parent_folders("node.hcl")
  expose = true
}

terraform {
  source = "${get_repo_root()}/modules/vm"
}

dependency "vm_template" {
  config_path = "../vm_template"
}

inputs = {
  inventory_path                  = "${get_repo_root()}/silverstone/k8s_cluster"
  proxmox_node                    = include.node.locals.proxmox_node
  proxmox_gateway                 = include.root.locals.proxmox_gateway
  vm_template_id                  = dependency.vm_template.outputs.vm_template_id
  vm_template_cloud_init_username = include.root.locals.vm_template_cloud_init_username
  vm_tags                         = ["terraform", "k8s"]
  vm_definition = [
    {
      vm_id            = 121
      type             = "manager"
      hostname         = "k8s-manager-1"
      cpu_cores        = 2
      cpu_limit        = 1
      cpu_units        = 100
      memory_dedicated = 4096
      disks = [{
        interface = "scsi0"
        format    = "raw"
        size      = 16
      }]
      ipv4_address = "10.0.0.21/24"
      startup = {
        order      = 4
        up_delay   = 10
        down_delay = 10
      }
    },
    {
      vm_id            = 131
      type             = "worker"
      hostname         = "k8s-worker-1"
      cpu_cores        = 8
      cpu_limit        = 4
      cpu_units        = 100
      memory_dedicated = 16384
      disks = [
        {
          interface = "scsi0"
          format    = "raw"
          size      = 16
        },
        {
          interface = "scsi1"
          format    = "raw"
          size      = 32
        }
      ]
      ipv4_address = "10.0.0.31/24"
      startup = {
        order      = 6
        up_delay   = 5
        down_delay = 5
      }
    },
    {
      vm_id            = 132
      type             = "worker"
      hostname         = "k8s-worker-2"
      cpu_cores        = 8
      cpu_limit        = 4
      cpu_units        = 100
      memory_dedicated = 16384
      disks = [
        {
          interface = "scsi0"
          format    = "raw"
          size      = 16
        },
        {
          interface = "scsi1"
          format    = "raw"
          size      = 32
        }
      ]
      ipv4_address = "10.0.0.32/24"
      startup = {
        order      = 6
        up_delay   = 5
        down_delay = 5
      }
    },
    {
      vm_id            = 133
      type             = "worker"
      hostname         = "k8s-worker-3"
      cpu_cores        = 8
      cpu_limit        = 4
      cpu_units        = 100
      memory_dedicated = 16384
      disks = [
        {
          interface = "scsi0"
          format    = "raw"
          size      = 16
        },
        {
          interface = "scsi1"
          format    = "raw"
          size      = 32
        }
      ]
      ipv4_address = "10.0.0.33/24"
      startup = {
        order      = 6
        up_delay   = 5
        down_delay = 5
      }
    }
  ]
}
