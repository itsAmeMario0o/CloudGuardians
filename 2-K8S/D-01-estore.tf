# # Create a namespace 
# resource "kubernetes_namespace_v1" "estore" {
#   metadata {
#     name = "estore"
#   }
#   depends_on = [
#     helm_release.tetragon
#   ]
# }

##
# Revisit this - https://github.com/hashicorp/terraform-provider-kubernetes/issues/2069
##

# Create a Null Resource and Provisioners
resource "null_resource" "kube_apply" {
  depends_on = [kubernetes_namespace_v1.estore]
    
## Local Exec Provisioner:  local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
  provisioner "local-exec" {
    command = "kubectl apply -f ${var.estore_mani}"
    #command = "kubectl apply -f ${var.estore_mani} -n ${kubernetes_namespace_v1.estore.metadata[0].name}"
    on_failure = continue
  }
}