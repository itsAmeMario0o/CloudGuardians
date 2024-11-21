resource "kubernetes_cluster_role" "admin_role" {
  metadata {
    name = "${aws_iam_user.admin_user.name}"
  }

  rule {
    api_groups = [""]
    resources  = ["*"]
    verbs      = ["*"]
  }
}