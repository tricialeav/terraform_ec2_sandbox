# In Progress

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
