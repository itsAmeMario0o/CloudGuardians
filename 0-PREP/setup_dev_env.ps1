##
# Run as administrator
# .\setup_dev_environment.ps1
##

# Function to check if a command exists, install it if it does not, and validate installation
function Install-AndValidate {
    param (
        [string]$Command,
        [string]$ChocoName,
        [string]$VersionCommand
    )

    # Check if the command is available
    if (!(Get-Command $Command -ErrorAction SilentlyContinue)) {
        Write-Output "$Command is not installed. Installing $ChocoName..."
        choco install $ChocoName -y

        # Validate installation
        if (Get-Command $Command -ErrorAction SilentlyContinue) {
            Write-Output "$Command installed successfully. Version:"
            & $Command $VersionCommand
        } else {
            Write-Output "Error: $Command installation failed."
        }
    } else {
        Write-Output "$Command is already installed. Skipping installation. Version:"
        & $Command $VersionCommand
    }
}

# Check if Chocolatey is installed, and install it if missing
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Output "Chocolatey is not installed. Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
} else {
    Write-Output "Chocolatey is already installed."
}

# Check and install Git
Install-AndValidate -Command "git" -ChocoName "git" -VersionCommand "--version"

# Check and install AWS CLI
Install-AndValidate -Command "aws" -ChocoName "awscli" -VersionCommand "--version"

# Check and install kubectl
Install-AndValidate -Command "kubectl" -ChocoName "kubernetes-cli" -VersionCommand "version --client"

# Check and install Terraform
Install-AndValidate -Command "terraform" -ChocoName "terraform" -VersionCommand "version"

# Check and install Cilium CLI
Install-AndValidate -Command "cilium" -ChocoName "cilium" -VersionCommand "version"

# Check and install Tetra (assuming it’s available via Chocolatey)
Install-AndValidate -Command "tetra" -ChocoName "tetra" -VersionCommand "version"

# Check and install eksctl
Install-AndValidate -Command "eksctl" -ChocoName "eksctl" -VersionCommand "version"

# Check and install Visual Studio Code
if (!(Get-Command "code" -ErrorAction SilentlyContinue)) {
    Write-Output "Visual Studio Code is not installed. Installing..."
    choco install vscode -y

    # Validate installation
    if (Get-Command "code" -ErrorAction SilentlyContinue) {
        Write-Output "Visual Studio Code installed successfully. Version:"
        code --version
    } else {
        Write-Output "Error: Visual Studio Code installation failed."
    }
} else {
    Write-Output "Visual Studio Code is already installed. Skipping installation. Version:"
    code --version
}

Write-Output "Setup complete!"