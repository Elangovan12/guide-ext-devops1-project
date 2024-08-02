# Create AMI from Snapshot
resource "aws_ami" "my-ami" {
  name                = "my-ami-from-snpsht"
  description         = "Am Ami Created from 10-May-2023 Snapshot"
  virtualization_type = "hvm"
  root_device_name    = "/dev/sda1"
  ena_support         = true
  ebs_block_device {
    device_name           = "/dev/sda1"
    volume_size           = 50
    volume_type           = "gp3"
    snapshot_id           = data.aws_ebs_snapshot.ebs_volume.id
    delete_on_termination = true
  }
}

# Create EC2 Instance
resource "aws_instance" "ec2_instance" {
  ami                    = aws_ami.my-ami.id
  instance_type          = "t3.medium"
  key_name               = "vscode-key"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id              = aws_default_subnet.default_az1.id
  iam_instance_profile   = "jenkins-ec2-server-admin-role"

  user_data = <<-EOT
    #!/bin/bash
    cd /home/ubuntu/
    mkdir 01-git-repos
    git clone https://github.com/Elangovan12/guide-ext-kubeadm-scripts.git /home/ubuntu/01-git-repos/guide-ext-kubeadm-scripts
    git clone https://github.com/Elangovan12/prodv-slf-terra-ec2vm.git /home/ubuntu/01-git-repos/prodv-slf-terra-ec2vm
    cd /home/ubuntu/01-git-repos/guide-ext-kubeadm-scripts/scripts
    sh /home/ubuntu/01-git-repos/guide-ext-kubeadm-scripts/scripts/k8s-init.sh
    sh /home/ubuntu/01-git-repos/guide-ext-kubeadm-scripts/scripts/master.sh
    cd /home/ubuntu/01-git-repos/prodv-slf-terra-ec2vm
    sh /home/ubuntu/01-git-repos/prodv-slf-terra-ec2vm/00_installs.sh
    EOT

  depends_on = [aws_ami.my-ami]

  tags = {
    Name        = "ec2-k8s-workspace"
    Terraform   = "true"
    Environment = "dev"
  }
}


