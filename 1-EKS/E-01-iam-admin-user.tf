# Resource: AWS IAM User - Admin User (Has Full AWS Access)
resource "aws_iam_user" "admin_user" {
  name = "${local.name}-labrat"  
  path = "/"
  force_destroy = true
  tags = local.common_tags
}

# Resource to create an IAM access key for the admin_user if the username is provided
resource "aws_iam_access_key" "admin_access_key" {
  user  = aws_iam_user.admin_user.name  # Link the access key to the created IAM user
}

# Resource: Admin Access Policy - Attach it to admin user
resource "aws_iam_user_policy_attachment" "admin_user" {
  user       = aws_iam_user.admin_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}