# Provision the node 

## Assumptions

Terraform must be installed locally. Access to the AWS key pair name from the AWS console and your local key.

## Provision

```
❯ terraform init
❯ terraform plan
```

Once the plan looks ok, trigger the provisioning 

```
❯ terraform apply --auto-approve
```

This uses the local folder `files` and transfers everything to the remote `t3.micro` instance home folder.

It then installs the `deb` package defined under the `variables.tf` 

```
variable "local_folder" {
  default = "./files"  # Path to local folder containing all the files
}

variable "deb_file" {
  default = "./nginx_1.26.3-1~jammy_amd64.deb"  # Path to local DEB file
}
```

Refer to other variables in the `variables.tf` file and adjust accordingly.

Once complete, go to the three lines of the output of `terraform apply --auto-approve` should have the public Ip of the node created

```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

instance_public_ip = "3.81.33.71"
```

Open the browser and paste this ip in the address bar to see the `nginx` default page to confirm the binaries were installed successfully.

This can be used to install any single "deb" package on the remote node.

Thanks.
