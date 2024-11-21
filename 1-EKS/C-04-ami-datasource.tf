# Get latest AMI ID for Amazon Linux2 OS

data "aws_ami" "amzlinux2" {
  most_recent = true
  owners = [ "amazon" ]

  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ] 
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}

/*
# Get latest AMI ID for Kali
# Subscribe to this image at 
# https://aws.amazon.com/marketplace/pp/prodview-fznsw3f7mq7to

data "aws_ami" "kali" {
  most_recent = true
  owners = [ "aws-marketplace" ]

  filter {
    name = "name"
    values = [ "kali-last-snapshot-amd64-*" ] 
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}
*/