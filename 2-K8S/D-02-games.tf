# # Create a namespace 
# resource "kubernetes_namespace_v1" "games" {
#   metadata {
#     name = "games"
#   }
#   depends_on = [
#     helm_release.tetragon
#   ]
# }


# Create a Null Resource and Provisioners
resource "null_resource" "kube_apply_svc" {
  depends_on = [
    kubernetes_namespace_v1.games
  ]
    
## Local Exec Provisioner:  local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
  provisioner "local-exec" {
    command = "kubectl apply -f ${var.game_mani} && kubectl apply -f ${var.game_service}"
    #command = "kubectl apply -f ${var.game_mani} -n ${kubernetes_namespace_v1.games.metadata[0].name} && kubectl apply -f ${var.game_service} -n ${kubernetes_namespace_v1.games.metadata[0].name}"
    on_failure = continue
  }
}