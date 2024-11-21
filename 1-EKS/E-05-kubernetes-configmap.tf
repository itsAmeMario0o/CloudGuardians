# Get AWS Account ID
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

# Locals Block
locals {
  configmap_roles = [
    {
      rolearn = "${aws_iam_role.eks_nodegroup_role.arn}"
      username = "system:node:{{EC2PrivateDNSName}}"
      groups = ["system:bootstrappers", "system:nodes"]
    },
  ]
  configmap_users = [
    {
      userarn = "${aws_iam_user.admin_user.arn}"
      username = "${aws_iam_user.admin_user.name}"
      groups = ["system:masters"]
    },
  ]
}

# Resource: Kubernetes Config Map
resource "kubernetes_config_map_v1" "aws_auth" {
  depends_on = [aws_eks_cluster.eks_cluster]
  metadata {
    name = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode(local.configmap_roles)
    mapUsers = yamlencode(local.configmap_users)
  }

}