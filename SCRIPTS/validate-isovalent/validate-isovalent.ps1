##
# Validate CLIs are available for Cilium Hubble & Tetragon
##

# Check if Cilium CLI is installed
if (-not (Get-Command cilium -ErrorAction SilentlyContinue)) {
    Write-Output "Cilium CLI is not installed. Please install the Cilium CLI."
    exit 1
} else {
    Write-Output "Cilium CLI version: $(cilium version)"
}

# Check if Hubble CLI is installed
if (-not (Get-Command hubble -ErrorAction SilentlyContinue)) {
    Write-Output "Hubble CLI is not installed. Please install the Hubble CLI."
    exit 1
} else {
    Write-Output "Hubble CLI version: $(hubble version)"
}

# Check if Tetra CLI is installed
if (-not (Get-Command tetra -ErrorAction SilentlyContinue)) {
    Write-Output "Tetra CLI is not installed. Please install the Tetra CLI."
    exit 1
} else {
    Write-Output "Tetra CLI version: $(tetra version)"
}

##
# Check Pods
##

# Wait for Cilium deployment to stabilize
Write-Output "Waiting for Cilium rollout to complete..."
Start-Sleep -Seconds 1
kubectl rollout status -n kube-system ds/cilium -w

# Wait for Tetragon deployment to stabilize
Write-Output "Waiting for Tetragon rollout to complete..."
Start-Sleep -Seconds 1
kubectl rollout status -n kube-system ds/tetragon -w

# Check status of Cilium and Hubble pods
Write-Output "Checking pod statuses for Cilium and Hubble..."
Start-Sleep -Seconds 1
kubectl get pods -n kube-system | Select-String -Pattern 'cilium|hubble'

# Check status of Tetragon pods
Write-Output "Checking pod statuses for Tetragon..."
Start-Sleep -Seconds 1
kubectl get pods -n kube-system | Select-String -Pattern 'tetragon'

##
# Check Cilium status and enable Hubble UI
##

# Validate Cilium installation
Write-Output "Validating Cilium status..."
cilium status

# Enable Hubble UI access
Write-Output "Enabling Hubble UI"
Write-Output "A new tab will open in your browser..."
cilium hubble ui