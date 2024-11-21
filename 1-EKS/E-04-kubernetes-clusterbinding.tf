resource "kubernetes_cluster_role_binding" "admin_binding" {
  metadata {
    name = "admin-clusterrolebinding"
  }

  role_ref {
    kind = "ClusterRole"
    name = kubernetes_cluster_role.admin_role.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind = "User"  # or "ServiceAccount"
    name = "${aws_iam_user.admin_user.name}"
    api_group = "rbac.authorization.k8s.io"
  }
}