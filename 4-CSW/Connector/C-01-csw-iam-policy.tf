# Define an IAM policy that specifies permissions granted to the user or role
resource "aws_iam_policy" "managed_policy" {
  name        = var.policy_name  # Use the provided policy name
  description = "Custom policy for Cisco Secure Workload connector"  # Describe the policy

  # Policy document (permissions)
  policy = jsonencode({
    Version = "2012-10-17"  # Set the policy version
    Statement = [
      {
        Effect   = "Allow"  # Allow the actions listed in the "Action" field
        Action   = [
          "iam:GetUser",
          "iam:ListUserPolicies",
          "iam:GetUserPolicy",
          "iam:ListAttachedUserPolicies",
          "iam:GetRole",
          "iam:ListAttachedRolePolicies",
          "iam:ListPolicyVersions",
          "iam:GetPolicyVersion",
          "iam:ListRolePolicies",
          "iam:GetRolePolicy",
          "ec2:DescribeRegions"
        ]
        Resource = "*"  # Allow these actions on all resources
      },
      {
        Effect   = "Allow"
        Action   = [
          "ec2:DescribeVpcs",
          "ec2:DescribeInstances",
          "ec2:DescribeNetworkInterfaces"
        ]
        Resource = "*"  # Allow these actions on all resources
      },
      {
        Effect   = "Allow"
        Action   = [
          "ec2:DescribeFlowLogs",
          "ec2:DescribeVpcs"
        ]
        Resource = "*"  # Allow these actions on all resources
      },
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = join(",", var.s3_resources)  # Use provided S3 resources (e.g., bucket ARNs)
      },
      {
        Effect   = "Allow"
        Action   = [
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeNetworkInterfaceAttribute",
          "ec2:DescribeSecurityGroups",
          "servicequotas:ListServiceQuotas",
          "eks:ListNodeGroups",
          "eks:DescribeNodegroup"
        ]
        Resource = "*"  # Allow these actions on all resources
      },
      {
        Effect   = "Allow"
        Action   = [
          "ec2:RevokeSecurityGroupIngress",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:CreateSecurityGroup",
          "ec2:RevokeSecurityGroupEgress",
          "ec2:DeleteSecurityGroup",
          "ec2:ModifyNetworkInterfaceAttribute",
          "ec2:CreateTags"
        ]
        Resource = join(",", var.virtual_private_networks)  # Use provided VPC ARNs for specific resources
      },
      {
        Effect   = "Allow"
        Action   = [
          "eks:DescribeCluster",
          "eks:ListClusters",
          "sts:AssumeRole"
        ]
        Resource = "*"  # Allow these actions on all resources
      },
      {
        Effect = "Allow",
        Action = [
          "elasticloadbalancing:DescribeLoadBalancers",
          "elasticloadbalancing:DescribeTags",
          "elasticloadbalancing:DescribeTargetGroups",
          "elasticloadbalancing:DescribeTargetHealth",
          "elasticloadbalancing:DescribeListeners",
          "elasticloadbalancing:DescribeLoadBalancerPolicyTypes",
          "elasticloadbalancing:DescribeLoadBalancerAttributes",
          "elasticloadbalancing:DescribeInstanceHealth",
          "elasticloadbalancing:DescribeListenerAttributes",
          "elasticloadbalancing:DescribeTargetGroupAttributes",
          "elasticloadbalancing:DescribeRules"
        ]
        Resource = "*" # Allow these actions on all resources
      }
    ]
  })
}