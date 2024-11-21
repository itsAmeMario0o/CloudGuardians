# 🚀 Terraform Wizardry: Conjuring EKS Clusters and Node Groups with Ease! 🧙‍♂️

Effortlessly install all the essential tools you need to kickstart your adventures. Ready, set, code!" 🚀✨


Welcome to the magical world of infrastructure as code, where deploying an AWS EKS cluster and its mighty node groups is as easy as a flick of the wand—or, in this case, a few Terraform commands! 🪄

**What's Happening in the Code?** 🌟

Our Terraform setup is designed to create a robust EKS cluster along with node groups. It meticulously configures IAM roles, security groups, and all the intricate details required to get your Kubernetes workloads up and running.Lastly, a bastion host is created that will act as a launchpad into our environment.


**Here's a glimpse of what you'll be doing**:


Crafting an EKS cluster that's ready for action.
Deploying node groups that can handle your Kubernetes pods with grace.
Configuring IAM roles and policies to ensure smooth operations.
Implement a Bastion host for jump access! 
Leveraging Terraform's power to automate the entire process.

**How to Cast Your Terraform Spell** 🧙‍♀️

Ready to bring your EKS cluster to life? Follow these simple incantations:

1. **Create a key**: Create a key pair that will be used for connecting to Bastion Host and EKS Node Group instances. In the AWS Console:
   
   EC2 -> Network & Security -> Key Pairs -> Create Key Pair

   Name: eks-lab-key
   Key Pair Type: RSA (leave to defaults)
   Private key file format: .pem
   Click on Create key pair
   COPY the downloaded key pair to 1-EKS/private-key folder

   ```bash
   cd 1-EKS/private-key
   chmod 400 eks-terraform-key.pem

2. **Initialize Terraform**: Prepare your environment.
   ```bash
   terraform init

3. **Validate the Configuration**: Ensure everything is in perfect harmony.
   ```bash
   terraform validate

4. **Plan the Deployment**: See the magic before it happens.
   ```bash
   terraform plan

5. **Apply the Changes**: Watch your infrastructure materialize.
   ```bash
   terraform apply -auto-approve

**Grab a schnaack**

Verify and Enjoy! 🎉

Once your cluster is up and running, use the AWS Management Console to explore your new creation. From cluster details to node statuses, everything is at your fingertips!

6. **Connect to Bastion**
   ```bash
   # Connect to Bastion Host
   ssh -i 1-EKS/eks-lab-key.pem ec2-user@<Elastic-IP-Bastion-Host>
   sudo su -
   cd /tmp
   ls -lrta

   NOTE: The file named "eks-lab-key.pem" copied from our local desktop to Bastion "/tmp" folder.