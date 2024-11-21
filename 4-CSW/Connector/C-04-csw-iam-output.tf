# Outputs to display the created IAM user ARN
output "secure_workload_iam_user_arn" {
  description = "The ARN of the IAM User for Secure Workload"
  value       = aws_iam_user.user.arn
}

# Outputs to display the created IAM user
output "secure_workload_username" {
  description = "The AWS username for Secure Workload"
  value       = aws_iam_user.user.name
}

# Outputs to display the created resources (IAM user and access keys)
output "access_key" {
  value = aws_iam_access_key.user_access_key.id  # Output the Access Key ID
}

output "secret_key_check_tfstate" {
  value = aws_iam_access_key.user_access_key.secret  # Output the Secret Access Key (note: it should be stored securely)
  sensitive = true
}

output "message_s3" {
  value = "Ensure CSW can read all buckets. Update bucket policies for specific buckets as needed."
}