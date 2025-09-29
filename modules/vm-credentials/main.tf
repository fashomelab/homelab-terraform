# labsterraform/modules/vm-credentials/main.tf

resource "random_password" "vm_password" {
  length           = 16
  override_special = "_%@"
  special          = true
}

resource "tls_private_key" "vm_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}