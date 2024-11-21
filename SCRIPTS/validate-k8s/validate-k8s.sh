# chmod +x validate-k8s.sh
# ./validate-k8s.sh

#!/bin/bash

# Redirect output to a file
exec > validate-k8s-output.txt 2>&1

# Function to print error messages and exit
function error_exit {
    echo "Checks failed, see the following output:" 1>&2
    echo "$1" 1>&2
    exit 1
}

# Set a timeout for kubectl commands
TIMEOUT=60s

# Function to run a command and handle errors
function run_command {
    echo "Running: $1"
    eval $1
    if [ $? -ne 0 ]; then
        error_exit "Error occurred while running: $1"
    fi
    echo
}

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    error_exit "kubectl could not be found. Please install kubectl."
fi

# Verify kubeconfig and current context
run_command "kubectl config view"
run_command "kubectl config current-context"

# Check API server health
run_command "kubectl get --raw='/healthz'"

# Check nodes status
run_command "kubectl get nodes -o wide"

# Describe each node
NODES=$(kubectl get nodes -o jsonpath='{.items[*].metadata.name}')
for NODE in $NODES; do
    run_command "kubectl describe node $NODE"
done

# List pods in kube-system namespace
run_command "kubectl get pods -n kube-system -o wide"

# Describe and get logs for each pod in kube-system namespace
PODS=$(kubectl get pods -n kube-system -o jsonpath='{.items[*].metadata.name}')
for POD in $PODS; do
    run_command "kubectl describe pod $POD -n kube-system"
    run_command "kubectl logs $POD -n kube-system"
done

# Discover API server URL from kubeconfig
API_SERVER_URL=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
if [ -z "$API_SERVER_URL" ]; then
    error_exit "Could not discover API server URL from kubeconfig."
fi
echo "Discovered API server URL: $API_SERVER_URL"

# Extract hostname from API server URL
API_SERVER_HOSTNAME=$(echo $API_SERVER_URL | awk -F[/:] '{print $4}')
if [ -z "$API_SERVER_HOSTNAME" ]; then
    error_exit "Could not extract API server hostname from URL: $API_SERVER_URL."
fi
echo "Discovered API server hostname: $API_SERVER_HOSTNAME"

# Increase client-side timeout for kubectl commands
run_command "kubectl get nodes --request-timeout=$TIMEOUT"

# Check cluster events
run_command "kubectl get events --sort-by='.metadata.creationTimestamp'"

echo "All checks completed successfully."