#!/bin/bash

##
# chmod +x setup_dev_env.sh
# ./setup_dev_env.sh
##

# Function to check if a command exists, install it if it does not, and validate installation
install_and_validate() {
  local command="$1"
  local brew_name="$2"
  local version_flag="$3"

  if ! command -v "$command" &>/dev/null; then
    echo "$command is not installed. Installing $brew_name..."
    brew install "$brew_name"
    # Check if the command installed successfully
    if command -v "$command" &>/dev/null; then
      echo "$command installed successfully. Version:"
      $command $version_flag
    else
      echo "Error: $command installation failed."
    fi
  else
    echo "$command is already installed. Skipping installation. Version:"
    $command $version_flag
  fi
}

# Check if Homebrew is installed, and install it if missing
if ! command -v brew &>/dev/null; then
  echo "Homebrew is not installed. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add Homebrew to PATH for immediate use
  eval "$(/opt/homebrew/bin/brew shellenv)" || eval "$(/usr/local/bin/brew shellenv)"
else
  echo "Homebrew is already installed."
fi

# Check and install Git
install_and_validate "git" "git" "--version"

# Check and install AWS CLI
install_and_validate "aws" "awscli" "--version"

# Check and install kubectl
install_and_validate "kubectl" "kubectl" "version --client"

# Check and install Terraform
install_and_validate "terraform" "terraform" "version"

# Check and install Cilium CLI
install_and_validate "cilium" "cilium-cli" "version"

# Check and install Tetra
install_and_validate "tetra" "tetra" "version"

# Check and install eksctl
install_and_validate "eksctl" "eksctl" "version"

# Check and install Visual Studio Code
if ! command -v code &>/dev/null; then
  echo "Visual Studio Code is not installed. Installing..."
  brew install --cask visual-studio-code
  # Validate installation
  if command -v code &>/dev/null; then
    echo "Visual Studio Code installed successfully. Version:"
    code --version
  else
    echo "Error: Visual Studio Code installation failed."
  fi
else
  echo "Visual Studio Code is already installed. Skipping installation. Version:"
  code --version
fi

echo "Setup complete!"