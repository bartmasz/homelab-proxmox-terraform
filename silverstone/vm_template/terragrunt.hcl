include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "node" {
  path   = find_in_parent_folders("node.hcl")
  expose = true
}

terraform {
    source = "${get_repo_root()}/modules/vm_template"
}

inputs = {
    proxmox_node = include.node.locals.proxmox_node
    ssh_key_path = include.root.locals.ssh_key_path
    vm_template_cloud_init_domain = include.root.locals.vm_template_cloud_init_domain
    vm_template_cloud_init_servers = include.root.locals.vm_template_cloud_init_servers
    vm_template_cloud_init_username = include.root.locals.vm_template_cloud_init_username
}
