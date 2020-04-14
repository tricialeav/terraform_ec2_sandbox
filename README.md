# In Progress

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

## Setting up SSH Access To Your Instance

Please see the AWS Documentation regarding SSH access found [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#how-to-generate-your-own-key-and-import-it-to-aws).

### Creating a new SSH keypair locally (optional) and connecting it to your instance:

1. Open Terminal
2. Copy/paste the following command into your terminal: 
```
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
3. Enter a file path where you would like to save your new keypair (typically stored in your .ssh folder i.e. /.ssh/<your_filename>) or press enter to accept the default.
4. Enter a passphrase for the keypair (optional). 
5. Create a new file in the root folder named "terraform.tfvars"
6. Copy/paste the following and save:
```
key_name          = <path to your key pair>
```

### Connecting to your AWS instance using your key pair

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
