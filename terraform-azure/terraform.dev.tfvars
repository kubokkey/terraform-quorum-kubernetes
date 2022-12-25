project_name = "dev-quorum"
arm_template_parameters = {
  resource_group = {
    name : "quorum"
    location : "japaneast"
  }
  subnet           = "192.168.0.0/20"
  vm_size          = "standard_b2ms"
  node_disksize_gb = 100
  node_count       = 1
}
