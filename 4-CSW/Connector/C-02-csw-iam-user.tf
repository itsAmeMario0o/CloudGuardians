# Resource to create an IAM user if a username is provided
resource "aws_iam_user" "user" {
  name  = var.username  # Assign the provided username to the IAM user
}

# Resource to create an IAM access key for the user if the username is provided
resource "aws_iam_access_key" "user_access_key" {
  user  = aws_iam_user.user.name  # Link the access key to the created IAM user
}

# Attach the managed IAM policy to the IAM user if the username is provided
resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  depends_on = [aws_iam_policy.managed_policy]
  user        = aws_iam_user.user.name  # Attach policy to the created user
  policy_arn  = aws_iam_policy.managed_policy.arn  # Created in csw-iam-policy
}