#!/bin/bash

# Make executeable
#chmod +x install_isovalent.sh

##
# Validate CLIs are available for Cilium Hubble & Tetragon
##

# Check if Cilium CLI is installed
if ! command -v cilium &> /dev/null; then
  echo "Cilium CLI is not installed. Please install the Cilium CLI."
  exit 1
else
  echo "Cilium CLI version: $(cilium version)"
fi

# Check if Hubble CLI is installed
if ! command -v hubble &> /dev/null; then
  echo "Hubble CLI is not installed. Please install the Hubble CLI."
  exit 1
else
  echo "Hubble CLI version: $(hubble version)"
fi

# Check if Tetra CLI is installed
if ! command -v tetra &> /dev/null; then
  echo "Tetra CLI is not installed. Please install the Tetra CLI."
  exit 1
else
  echo "Tetra CLI version: $(tetra version)"
fi

##
# Check Pods
##

# Wait for Cilium deployment to stabilize
echo "Waiting for Cilium rollout to complete..."
sleep 1
kubectl rollout status -n kube-system ds/cilium -w

# Wait for Tetragon deployment to stabilize
echo "Waiting for Tetragon rollout to complete..."
sleep 1
kubectl rollout status -n kube-system ds/tetragon -w

# Check status of Cilium and Hubble pods
echo "Checking pod statuses for Cilium and Hubble..."
sleep 1
kubectl get pods -n kube-system | grep -E 'cilium|hubble'

# Check status of Tetragon pods
echo "Checking pod statuses for Tetragon..."
sleep 1
kubectl get pods -n kube-system | grep tetragon

##
# Check Cilium status and enable Hubble UI
##

# Validate Cilium installation
echo "Validating Cilium status..."
cilium status

# Enable Hubble UI access
echo "Enabling Hubble UI"
echo "A new tab will open in your browser..."
cilium hubble ui