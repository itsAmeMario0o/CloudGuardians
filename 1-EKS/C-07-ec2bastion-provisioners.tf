##
# Copy key to Bastion & Provide VPC info
##

# Create a Null Resource and Provisioners
resource "null_resource" "copy_ec2_keys" {
  depends_on = [module.ec2_public]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type     = "ssh"
    host     = aws_eip.bastion_eip.public_ip   
    user     = "ec2-user"
    password = ""
    private_key = file("private-key/eks-lab-key.pem")
  }  

## File Provisioner: Copies the lab-key.pem file to /tmp/lab-key.pem
  provisioner "file" {
    source      = "private-key/eks-lab-key.pem"
    destination = "/tmp/eks-lab-key.pem"
  }
## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/eks-lab-key.pem"
    ]
  }
}