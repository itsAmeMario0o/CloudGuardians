##
# Retrieve the access credentials and update kubeconfig
##

# Create a Null Resource and Provisioners
resource "null_resource" "update_kubeconfig" {
  depends_on = [aws_eks_cluster.eks_cluster]
    
## Local Exec Provisioner:  update-kubeconfig
  provisioner "local-exec" {
    command = "aws eks --region ${var.aws_region} update-kubeconfig --name ${aws_eks_cluster.eks_cluster.name}"
    on_failure = continue
  }
}