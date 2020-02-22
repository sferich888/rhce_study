# We'll use ansible to execute the key configuration items, as ansible is better at configuration management. 
resource "null_resource" "local_libvirt_config_tls" {
  provisioner "local-exec" {
    command = "ansible -b -i localhost, all -c local -m ini_file -a 'path=/etc/libvirt/libvirtd.conf section=\"\" option=listen_tls value=0' --extra-vars='ansible_become_password=${var.ansible_become_password}'"
  }
}

resource "null_resource" "local_libvirt_config_tcp" {
  provisioner "local-exec" {
    command = "ansible -b -i localhost, all -c local -m ini_file -a 'path=/etc/libvirt/libvirtd.conf section=\"\" option=listen_tcp value=1' --extra-vars='ansible_become_password=${var.ansible_become_password}'"
  }
}

resource "null_resource" "local_libvirt_config_auth_tcp" {
  provisioner "local-exec" {
    command = "ansible -b -i localhost, all -c local -m ini_file -a 'path=/etc/libvirt/libvirtd.conf section=\"\" option=auth_tcp value=\"none\"' --extra-vars='ansible_become_password=${var.ansible_become_password}'"
  }
}

resource "null_resource" "local_libvirt_config_tcp_port" {
  provisioner "local-exec" {
    command = "ansible -b -i localhost, all -c local -m ini_file -a 'path=/etc/libvirt/libvirtd.conf section=\"\" option=tcp_port value=\"16509\"' --extra-vars='ansible_become_password=${var.ansible_become_password}'"
  }
}

resource "null_resource" "local_libvirt_config_args" {
  provisioner "local-exec" {
    command = "ansible -b -i localhost, all -c local -m ini_file -a 'path=/etc/sysconfig/libvirtd section=\"\" option=LIBVIRTD_ARGS value=\"--timeout 120 --listen\"' --extra-vars='ansible_become_password=${var.ansible_become_password}'"
  }
}

resource "null_resource" "local_libvirtd_restart" {
  provisioner "local-exec" {
    command = "systemctl restart libvirtd"
  }
  depends_on = [
    null_resource.local_libvirt_config_tls,
    null_resource.local_libvirt_config_tcp,
    null_resource.local_libvirt_config_auth_tcp,
    null_resource.local_libvirt_config_tcp_port,
    null_resource.local_libvirt_config_args,
  ]
}
