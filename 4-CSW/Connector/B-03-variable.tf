# Define variables to store user inputs
variable "policy_name" {
  type    = string
  default = "ciscoworkload-policy"  # Default policy name
}

variable "username" {
  type    = string
  default = "ciscoworkload-user" # Default user name
}

variable "s3_resources" {
  type    = list(string)
  default = ["*"]  # Default S3 resources (can be overridden with specific S3 bucket ARNs)
}

variable "virtual_private_networks" {
  type    = list(string)
  default = ["*"]  # Default VPCs (can be overridden with specific VPC ARNs)
}