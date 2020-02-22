The following scripts help you setup a study lab to practice.

- This write-up assumes your already running Fedora 31

Use the `hypervisor_setup` scripts to prepare your host(hypervisor). 
Use the `lab_setup` scripts to deploy systems that you can use as lab.

## Host Setup (meeting pre-requisites)
To use these scripts you may need to prepare your host, by making sure you can run the following: 

1. `terraform version`
<!-- 1. `ansible --version` -->

### To install libvirt: 

#### On Fedora

1. `sudo dnf install genisoimage libvirt libvirt-daemon-kvm libvirt-devel qemu-kvm virt-install virt-manager`

#### On Fedora Silverblue 

1. `sudo rpm-ostree install genisoimage libvirt libvirt-daemon-kvm libvirt-devel qemu-kvm virt-install virt-manager`
1. `sudo systemctl restart`

#### libvirt setup instructions

1. `sudo systemctl enable --now libvirtd`
1. `echo "net.ipv4.ip_forward = 1" | sudo tee /etc/sysctl.d/99-ipforward.conf && sudo sysctl -p /etc/sysctl.d/99-ipforward.conf`
1. `sudo systemctl enable libvirtd-tcp.socket && sudo systemctl start libvirtd-tcp.socket`
1. `sudo firewall-cmd --add-rich-rule "rule service name="libvirt" reject" && sudo firewall-cmd --zone=dmz --change-interface=virbr0 && sudo firewall-cmd --zone=dmz --change-interface=tt0 && sudo firewall-cmd --zone=dmz --add-service=libvirt`

### To install terraform: 

- [Official terraform install Instructions](https://learn.hashicorp.com/terraform/getting-started/install.html)
1. `wget https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_linux_amd64.zip`
1. `unzip terraform_0.12.21_linux_amd64.zip`
1. `mv terraform ~/.local/bin`
    - You might need to create this directory `mkdir ~/.local/bin`, it should already be in your path. 
    - run: `echo $PATH` to check, and confirm. 

#### Install the terraform libvirt (plugin)

- [Official plugin install instructions](https://github.com/dmacvicar/terraform-provider-libvirt)
1. `wget https://github.com/dmacvicar/terraform-provider-libvirt/releases/download/v0.6.1/terraform-provider-libvirt-0.6.1+git.1578064534.db13b678.Fedora_28.x86_64.tar.gz`
1. `mkdir ~/.terraform.d/plugins && tar xvf terraform-provider-libvirt-0.6.1+git.1578064534.db13b678.Fedora_28.x86_64.tar.gz && mv terraform-provider-libvirt ~/.terraform.d/plugins`

**Note**: Due to a [bug](https://github.com/dmacvicar/terraform-provider-libvirt/issues/665) in the terraform libvirt plugin, you need to compile and use a version; with the following [fix](https://github.com/dmacvicar/terraform-provider-libvirt/pull/707). Use instructions in the [Official plugin install instructions](https://github.com/dmacvicar/terraform-provider-libvirt) to accomplish this. 

<!-- ### To install Ansible: 

#### On Fedora

1. `sudo dnf install ansible`

#### On Fedora Silverblue 

1. `sudo rpm-ostree install ansible`
1. `sudo systemctl restart` --> 
