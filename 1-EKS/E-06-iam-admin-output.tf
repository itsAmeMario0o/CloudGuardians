# Outputs to display the created IAM user
output "bastion_admin_username" {
  description = "The AWS username for Administrative Access"
  value       = aws_iam_user.admin_user.name
}

# Outputs to display the created resources (IAM user and access keys)
output "admin_access_key" {
  value = aws_iam_access_key.admin_access_key.id  # Output the Access Key ID
}

output "secret_key_check_tfstate" {
  value = aws_iam_access_key.admin_access_key.secret  # Output the Secret Access Key (note: it should be stored securely)
  sensitive = true
}