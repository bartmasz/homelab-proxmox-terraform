resource "local_file" "ansible_inventory" {
  depends_on = [proxmox_virtual_environment_vm.vm]

  filename        = "${var.inventory_path}/inventory.ini"
  file_permission = 644
  content = templatefile(
    "${path.module}/ansible_inventory.tpl",
    {
      vm_user  = var.vm_template_cloud_init_username
      managers = local.manager_details
      workers  = local.worker_details
    }
  )
}
