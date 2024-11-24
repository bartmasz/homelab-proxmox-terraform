locals {
  vms = [for vm in proxmox_virtual_environment_vm.vm : {
    name = vm.name
    tags = flatten(vm.tags)
    ip   = [for ip in flatten(vm.ipv4_addresses) : ip if ip != "127.0.0.1"][0]
  } if contains(vm.tags, "k8s")]

  manager_details = [for vm in local.vms : vm if contains(vm.tags, "manager")]
  worker_details  = [for vm in local.vms : vm if contains(vm.tags, "worker")]
}
