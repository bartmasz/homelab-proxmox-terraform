include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "node" {
  path   = find_in_parent_folders("node.hcl")
  expose = true
}

terraform {
  source = "${get_repo_root()}/modules/ct"
}

inputs = {
  proxmox_node                    = include.node.locals.proxmox_node
  proxmox_gateway                 = include.root.locals.proxmox_gateway
  ssh_key_path                    = include.root.locals.ssh_key_path
  ct_tags                         = ["terraform", "homelab"]
  template_file_id = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  operating_system_type = "debian"
  dns_servers = ["10.0.0.9", "1.1.1.1"]
  dns_domain = "silverlab.libator.net"
  ct_definition = []
}
