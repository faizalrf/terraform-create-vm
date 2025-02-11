variable "name_prefix" {
  description = "Prefix for the instance name"
  type        = string
  default     = "faisal"  # Change this as needed
}
variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "additional_port" {
  default = 80
}

variable "ami_id" {
  default = "ami-0e1bed4f06a3b463d"  # Change to your AMI
}

variable "key_pair_name" {
  default = "faisal-test-key-pair"  # Replace with your AWS key pair name
}

variable "ssh_private_key_path" {
  default = "~/.ssh/id_ed25519"  # Path to your private key for SSH
}

variable "deb_file" {
  default = "./nginx_1.26.3-1~jammy_amd64.deb"  # Path to local DEB file
}

variable "local_folder" {
  default = "./files"  # Path to folder containing other files
}

variable "remote_user" {
  default = "ubuntu"  # The default user for Ubuntu-based EC2 instances
}

variable "remote_home_path" {
  default = "/home/ubuntu"  # Where files will be transferred
}
