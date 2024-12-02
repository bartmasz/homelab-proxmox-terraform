locals {
  proxmox_gateway                 = "10.0.0.1"
  homelab_domain                  = "homelab.libator.net"
  ssh_key_path                    = "~/.ssh/id_ed25519.pub"
  vm_template_cloud_init_domain   = "homelab.libator.net"
  vm_template_cloud_init_servers  = ["10.0.0.9", "1.1.1.1"]
  vm_template_cloud_init_username = "bartek"
}

generate "provider" {
  path      = "provider_proxmox.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.68.0"
    }
  }
}

provider "proxmox" {
  insecure = true
  ssh {
    agent = true
    username = "terraform"
    private_key = file("~/.ssh/id_ed25519")
    node {
      name    = "silverstone"
      address = "10.0.0.2"
    }
    node {
      name    = "dell"
      address = "10.0.0.3"
    }
  }
}
EOF
}
