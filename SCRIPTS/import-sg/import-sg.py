import boto3
import subprocess
import os

def describe_vpcs(ec2_client):
    """Returns a list of VPC IDs and their names (if available)."""
    vpcs = ec2_client.describe_vpcs()
    vpc_list = [(vpc['VpcId'], vpc.get('Tags', [{'Value': 'Unnamed VPC'}])[0]['Value']) for vpc in vpcs['Vpcs']]
    return vpc_list

def describe_security_groups(ec2_client, vpc_id):
    """Returns a list of security group IDs for a given VPC."""
    security_groups = ec2_client.describe_security_groups(Filters=[{'Name': 'vpc-id', 'Values': [vpc_id]}])
    return [sg['GroupId'] for sg in security_groups['SecurityGroups']]

def terraform_init():
    """Initializes Terraform in the current directory."""
    print("Initializing Terraform...")
    subprocess.run(["terraform", "init"], check=True)

def terraform_import(resource_type, resource_name, resource_id):
    """Imports an AWS resource into Terraform state."""
    try:
        subprocess.run(["terraform", "import", f"{resource_type}.{resource_name}", resource_id], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error importing {resource_name}: {e}")

def write_provider_file(region):
    """Creates a Terraform provider configuration file."""
    content = f"""
provider "aws" {{
  region = "{region}"
}}
"""
    with open('provider.tf', 'w') as f:
        f.write(content.strip())
    print("Created provider.tf")

def create_security_group_config(sg_id):
    """Creates a Terraform configuration file for a security group."""
    config_content = f"""
resource "aws_security_group" "imported_sg_{sg_id}" {{
  # Add required resource arguments here
}}
"""
    with open(f"sg_{sg_id}.tf", 'w') as f:
        f.write(config_content.strip())

def select_vpc(vpcs):
    """Prompts the user to select a VPC from the list."""
    print("Available VPCs:")
    for index, (vpc_id, vpc_name) in enumerate(vpcs):
        print(f"{index + 1}: {vpc_name} (ID: {vpc_id})")

    choice = int(input("Select a VPC by number: ")) - 1
    if 0 <= choice < len(vpcs):
        return vpcs[choice][0]
    else:
        print("Invalid choice. Please try again.")
        return select_vpc(vpcs)

def main():
    # Ask the user for the AWS region
    region = input("Enter the AWS region (e.g., us-east-1): ")

    # Initialize Boto3 client for EC2 with the specified region
    ec2_client = boto3.client('ec2', region_name=region)

    # Get VPCs and prompt user to select one
    vpcs = describe_vpcs(ec2_client)
    selected_vpc_id = select_vpc(vpcs)

    # Setup Terraform configuration directory
    os.makedirs("terraform_configs", exist_ok=True)
    os.chdir("terraform_configs")

    # Create provider configuration
    write_provider_file(region)

    # Initialize Terraform
    terraform_init()

    # Import Security Groups for the selected VPC
    for sg_id in describe_security_groups(ec2_client, selected_vpc_id):
        create_security_group_config(sg_id)  # Create a config file for the SG
        resource_name = f"imported_sg_{sg_id}"
        terraform_import("aws_security_group", resource_name, sg_id)

if __name__ == "__main__":
    main()