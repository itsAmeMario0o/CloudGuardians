# Security Group for EKS Node Group - Placeholder file


#   resource "aws_security_group" "eks" {
#     name        = "${var.env_name} eks cluster"
#     description = "Allow traffic"
#     vpc_id      = var.vpc_id

#     ingress {
#       description      = "To World"
#       from_port        = 0
#       to_port          = 0
#       protocol         = "-1"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#     }

#     egress {
#       from_port        = 0
#       to_port          = 0
#       protocol         = "-1"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#     }

#     tags = merge({
#       Name = "EKS ${var.env_name}",
#       "kubernetes.io/cluster/${local.eks_name}": "owned"
#     }, var.tags)
#   }
