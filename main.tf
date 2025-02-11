provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "t3_micro" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_pair_name
  security_groups = [aws_security_group.instance_sg.name]

  tags = {
    Name = "${var.name_prefix}-terraform-t3-micro"
  }

  # First provisioner: copy the entire local folder (which includes the DEB file)
  provisioner "file" {
    source      = var.local_folder
    destination = "${var.remote_home_path}/data"

    connection {
      type        = "ssh"
      user        = var.remote_user
      private_key = file(var.ssh_private_key_path)
      host        = self.public_ip
    }
  }

  # Second provisioner: run remote commands to update apt and install the DEB
  provisioner "remote-exec" {
    inline = [
      "sleep 240",  # Pause as needed
      "sudo cp ${var.remote_home_path}/data/${basename(var.deb_file)} /tmp/", # Copy to tmp before installation
      "sudo apt update -y && sudo apt install /tmp/${basename(var.deb_file)} -y"
    ]

    connection {
      type        = "ssh"
      user        = var.remote_user
      private_key = file(var.ssh_private_key_path)
      host        = self.public_ip
    }
  }
}

resource "aws_security_group" "instance_sg" {
  name        = "${var.name_prefix}-terraform-instance-sg"
  description = "Allow SSH and necessary ports"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict in production
  }

  ingress {
    from_port   = var.additional_port
    to_port     = var.additional_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance_public_ip" {
  value = aws_instance.t3_micro.public_ip
}