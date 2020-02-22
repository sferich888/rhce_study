These terraform configs/scripts setup your libvirt hypervisor and local NetworkManager (dnsmasq).

1. `terraform init`
1. `terraform apply -auto-approve` 
1. Enter your 'sudo' password (when prompted).
1. Enter your password (when prompted).

- **TODO**: Fix the `hypervisor_libvirt_config.tf` script! 
  - While it puts 'semi' good configurations in place; they are not quite right, due to libvirt configs not being true ini files.
  - Fixing the errors (~3 of them) and restarting libvirtd (is good practice for the RHCE). 
