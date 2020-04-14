# Terraform AWS EC2 Sandbox Environment

# Introduction

This project uses Terraform (Infrastructure as Code) to spin up an AWS EC2 sandbox environment in the us-west-2 (Oregon) region/us-west-2a Availability Zone. The environment includes: 

1. Single VPC with an Internet Gateway
2. Public Subnet
    1. Public Route Table
        1. Public ipv4 destination with IGW target
        2. Public ipv6 destination with IGW target
        3. Local target 
    2. Public Subnet Network ACL
        1. Inbound Allow
            1. HTTP (public)
            2. HTTPS (public)
            3. SSH (My IP)
            4. ICMP (My IP)
    3. Public Security Groups
        1. Allow Ping and SSH from my IP
        2. Allow HTTP and HTTPS from public internet
    4. Public EC2 Instance
        1. Amazon Linux 2 AMI 2.0.20200406.0 x86_64 HVM gp2 t2.micro
        2. IPV4 Public IP address
3. Private Subnet
    1. Private Route Table
        1. Local Target
    2. Private Subnet Network ACL
        1. HTTP (from VPC CIDR)
        2. HTTPS (from VPC CIDR)
    3. Private Security Group
        1. Allow HTTP and HTTPS from Public Subnet CIDR
    4. Private EC2 Instance
        1. Amazon Linux 2 AMI 2.0.20200406.0 x86_64 HVM gp2 t2.micro

# Prerequisites

1. You will need to have access to an AWS account to spin up the resources in. Most of the included resources will qualify for free tier usage but you may incur some costs if your account has surpassed free tier usage terms. Please see the AWS Official links below for information on how to create an account and free tier usage: 
    1. [Get an AWS Account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)
    2. [AWS Free Tier Usage](https://aws.amazon.com/premiumsupport/knowledge-center/what-is-free-tier/)
2. Terraform version 0.12
    1. [Download Terraform](https://www.terraform.io/downloads.html)
3. An IDE of your choice
4. A keypair used to SSH into your linux instances. Please see [#-ssh-instructions] below.

# Project Setup

## AWS Account Setup

1. In your browser, log into your AWS Management Console. 
2. Follow the [AWS Official Instructions](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_create-admin-group.html) to create an Admin User and Group. Make sure that the user has both Programmatic and AWS Management Console Access enabled. 
3. Create your programmatic access keys for your admin user role by following the [Official AWS Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html).

## Terraform Setup

1. Clone the repo to your local machine. 
2. Open the project using an IDE of your choosing. 
3. In the root folder, create a file called "terraform.tfvars". This will be used to pass in your [SSH credentials](#-ssh-instructions). 
4. In your terminal, navigate to the root of the project folder. 
5. Allow Terraform to use your AWS Programmatic Access credentials:
    1. Option 1 (recommended): 
        1. Configure your [AWS config and credential files](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) and use either the default or a custom profile. 
        2. In your terraform.tfvars file, create the following entry: 
        ```
        profile = <the name of your AWS profile>
        ```
    2. Option 2: 
        1. Using your AWS Programmatic Access credentials from the previous step, enter the following commands to [configure your AWS credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html) (this allows Terraform to access your account): 
        ``` 
        $ export AWS_ACCESS_KEY_ID=<your AWS access Key>
        $ export AWS_SECRET_ACCESS_KEY=<your AWS Secret Access Key>
        $ export AWS_DEFAULT_REGION=us-west-2
        ```
        2. In the root of your project, open the main.tf file. 
        3. In the provider "aws" {} block, remove the following line: 
        ```
        profile = var.profile
        ```
6. In your terminal, run the following commands in the project's root directory: 
```
$ terraform init
$ terraform validate
$ terraform plan
```
7. The terraform plan command will generate a list of the resources to be spun up. It is best practice to review the plan before applying. 
8. Finally, run the following command to apply your changes and spin up the AWS resources in your account: 
```
$ terraform apply --auto-approve
```

More information about the terraform commands can be found [here](https://www.terraform.io/docs/commands/index.html).

# SSH Instructions

Please see the Official AWS Documentation regarding SSH found [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#how-to-generate-your-own-key-and-import-it-to-aws).

## Creating a new SSH keypair locally (optional) and connecting it to your instance:

1. Open Terminal
2. Copy/paste the following command into your terminal, replacing the example email with your own: 
```
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
3. Enter a file path where you would like to save your new keypair (typically stored in your .ssh folder i.e. /.ssh/<your_filename>) or press enter to accept the default.
4. Enter a passphrase for the keypair (optional but recommended). 
5. Create a new file in the root folder named "terraform.tfvars"
6. Copy/paste the following and save:
```
key_name          = <path to your key pair>
```

## Connecting to your AWS instance using your key pair

[AWS Official Documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html)
1. Log into your AWS Management Console.
2. Under the Services dropdown, select EC2. 
3. Select your Public EC2 Instance. 
4. Click the "connect" button at the top of the page.
5. Copy the instance's Public IP. 
6. In your terminal, navigate to the keypair directory. 
7. Enter the following commands in your terminal: 
```
$ chmod 400 <your_private_key>
$ ssh -i "<your_private_key>" ec2-user@<Public IP>
```
8. You will be asked if you want to continue connecting. Type yes.

# Project Cleanup

1. When you are finished, your AWS resources should be taken down to avoid potential charges to your AWS account. 
    1. In your terminal, navigate to the root of the project. 
    2. Copy/paste the following command: 
    ```
    $ terraform destroy --auto-approve
    ```
