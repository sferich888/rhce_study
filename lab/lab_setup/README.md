These scripts will deploy the necessary lab to study for the RHCSA and RHCE exams. 

This will deploy a network, that you can access from your host/hypervisor, and if the hypervisor setup (is aligned) DNS to the hosts should also work.
This means that you can ssh to the systems using the `student` user and `client.rhce.lab` and `server.rhce.lab` hostnames. 
Without the section below (a `terraform.tfvars` file the ssh access will not work; as you will not provided an ssh key for the defined user). 

- You can manipulate the default behavior of these scripts (recommended) by creating a `terraform.tfvars` file, and populating the following fields: 
```
username = "student"
ssh_key = "ssh-rsa AAAA...= user@hostname"

clientVM_name = "client"
clientVM_ram = 2048
clientVM_vcpus = 2
clientVM_ip = ["192.168.100.1"]
# clientVM_source_image = "/var/lib/libvirt/images/CentOS-8-GenericCloud-8.1.1911-20200113.3.x86_64.qcow2"
## The above is used if you don't have an internet connection. You first need to download the image (with an internet connnection). 
## This also keeps the image from being downloaded with each deployment.
## Its recommended (because of selinux) that you place the image under `/var/lib/libvrirt/images`.

serverVM_name = "server"
serverVM_ram = 4096
serverVM_vcpus = 4
serverVM_storage_volume_size = 1073741824
serverVM_storage_volume_count = 2
serverVM_ip = ["192.168.100.10"]
# serverVM_source_image = "/var/lib/libvirt/images/CentOS-8-GenericCloud-8.1.1911-20200113.3.x86_64.qcow2"
## The above is used if you don't have an internet connection. You first need to download the image (with an internet connection). 
## This also keeps the image from being downloaded with each deployment.
## Its recommended (because of selinux) that you place the image under `/var/lib/libvrirt/images`.
```

To use the scripts you simply need to run the following: 

1. `terrafomr init`
1. `terraform apply -auto-approve`

To take down the lab environment you simply need to run: 

1. `terraform destroy -auto-approve`
