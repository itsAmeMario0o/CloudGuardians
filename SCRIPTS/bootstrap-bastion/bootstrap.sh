#!/bin/bash

# Constants
AWS_REGION="us-east-1"
EKS_CLUSTER_NAME="cisco-test-ekslab"  # Replace with your EKS cluster name

# Have your AWS access & secret key available
echo "Check the tfstate for the access and secret key!"

# Step 1: Download and install kubectl
echo "Downloading kubectl..."
curl -LO "https://s3.us-west-2.amazonaws.com/amazon-eks/1.27.16/2024-09-11/bin/linux/amd64/kubectl"

echo "Installing kubectl..."
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Verify kubectl installation
kubectl version --client

# Step 2: AWS CLI configure
echo "Configuring AWS CLI..."
aws configure

# Step 3: Update kubeconfig for EKS cluster
echo "Updating kubeconfig for EKS cluster..."
aws eks update-kubeconfig --region $AWS_REGION --name $EKS_CLUSTER_NAME

# Verify kubeconfig update
kubectl cluster-info

echo "Setup complete. You can now perform administrative functions on the EKS environment."