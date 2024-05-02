# Hello World Web Application with ASP.NET Core

This repository contains a simple `"Hello World"` web application built with ASP.NET Core. It displays a custom greeting message that includes the current server time. Additionally, it logs each request to a file `(log.txt)` and standard output, including the timestamp and the requested path.

## Prerequisites
Before you begin, ensure you have the following installed on your machine:

- Visual Studio .NET (version 5.0.0 or higher)
- .NET SDK (version 6.0 or higher)

## Setup Instructions
Follow these steps to manually create the ASP.NET Core application:

- Open Visual Studio.
- Select Create a new project from the start window.
- Choose ASP.NET Core Web Application template.
- Provide a name for your project (e.g., AWSTask1) and click Create.
- In the Create a new ASP.NET Core web application dialog: Select .NET Core and a suitable version.
- Choose ASP.NET Core 3.1 or higher.
- Select Web Application (Model-View-Controller) template.
- Click Create.
- Right click on Solution and locate to add a Class and create a class, name it as `Startup.cs`

### Implement the Startup Class:
- Open the `Startup.cs` file in your project.
- Implement the `Configure` method, which is called by the ASP.NET Core runtime to configure the application's request processing pipeline.
#### Middleware for Request Logging:
- Inside the Configure method, use the Use extension method of `IApplicationBuilder` to add middleware for logging each request.
- The middleware function logs the timestamp and requested path to both a file `(log.txt)` and standard output.
- The `await next()` statement calls the next middleware in the pipeline.
#### Define the Request Handling Middleware:
- Use the Run extension method of IApplicationBuilder to define the middleware for handling requests.
- Inside the middleware function, generate the current server time (currentTime) and construct an HTML message (message) containing the "Hello World!" greeting and the current server time.
- Write the HTML message to the response using context.Response.WriteAsync.

### Implement Program Class
- Implement the  `Main` method, which serves as the entry point for the application.
- Inside the Main method, call the `CreateHostBuilder` method to configure the web host and run the application.
#### Create Host Builder:
- Implement the `CreateHostBuilder` method, which creates and configures the web host.
- Use the Host class to create a default host builder with specified command-line arguments (args).
- Use the `ConfigureWebHostDefaults` method to configure the web host with default settings.
- Inside the webBuilder configuration, use the UseStartup method to specify the startup class (Startup) for the application.

## Run the Application:
- Build the project by selecting `"Build" -> "Build Solution"` from the Visual Studio menu.
- Press `F5` or select `"Debug" -> "Start Debugging"` to run the application.
- The application will start and display the `"Hello World!"` greeting message along with the current server time when accessed through a web browser and log each request to a file named `log.txt` including the timestamp and the requested path.


# Deploying an ASP.NET Web Application on Windows IIS Server and Linux Server using AWS EC2 Instance

## Prerequisites for AWS
Before deploying an ASP.NET web application on AWS EC2 instances, you need an AWS account. Follow these steps to create a free trial account and set up an IAM user with Multi-Factor Authentication (MFA):

Step 1: Create an AWS Free Trial Account

- Go to the `AWS Free Tier page`.
- Click on `Create a Free Account` and follow the on-screen instructions.
- Provide your email address, password, and account information.
- Enter your payment information (credit card required for verification purposes, but you won't be charged during the free trial period).
- Complete the registration process and verify your email address.

Step 2: Create an `IAM User`

- Sign in to the `AWS Management Console`.
- In the AWS services search bar, type `"IAM"` and select `"IAM"` from the dropdown.
- In the IAM dashboard, click on `"Users"` in the left sidebar, then click `"Add user"`.
- Enter a username for the new IAM user and select `"Programmatic access"` as the access type.
- Click "Next: Permissions" and attach policies according to your requirements (e.g., "AmazonEC2FullAccess" for EC2 instance management).
- Click "Next: Tags" (optional) and add tags if needed, then click "Next: Review".
- Review the user details and click `"Create user"`.
- Make a note of the `Access key ID` and `Secret access key` provided. These will be needed for programmatic access to AWS services.

Step 3: Add `Multi-Factor Authentication (MFA)`

- In the IAM dashboard, click on `"Users"` in the left sidebar.
- Click on the username of the IAM user you created earlier.
- Navigate to the `"Security credentials"` tab.
- Under `"Assigned MFA device"`, click `"Manage MFA device"` and follow the prompts to set up MFA using a virtual or hardware device.
- Once MFA is enabled, log out and log back in to test the MFA authentication.


## Brief Introduction about AWS and EC2 Instance
`Amazon Web Services (AWS)` is a cloud computing platform offered by Amazon. It provides a wide range of cloud services, including computing power, storage, and databases, allowing businesses to scale and grow without the need for physical infrastructure.

`Amazon Elastic Compute Cloud (Amazon EC2)` is a web service that provides resizable compute capacity in the cloud. It allows users to launch and manage virtual servers, known as instances, on the AWS cloud.


### Steps to Create an EC2 Instance

After setting up your AWS account and IAM user, let's proceed with creating an EC2 instance:

Step 1: Sign in to the AWS Management Console
- Go to the `AWS Management Console`.
- Sign in using your AWS account credentials.

Step 2: Navigate to EC2 Dashboard
- In the AWS services search bar, type `"EC2"` and select `"EC2"` from the dropdown.

Step 3: Launch an EC2 Instance
- In the EC2 dashboard, click on `Launch instance`.
- Choose an `Amazon Machine Image (AMI)` - select an AMI suitable for hosting ASP.NET web applications (e.g., Windows Server for IIS or Amazon Linux for Linux Server).
- Choose an Instance Type - select an  `instance type` based on your requirements (e.g., `t2.micro` for free tier usage).
- Configure Instance - optionally, configure instance details such as network settings, storage, tags, etc.
- Add Storage - configure storage settings as needed.
- Configure Security Group - define inbound and outbound rules to control traffic to your instance (e.g., allow HTTP and HTTPS traffic).
- Review Instance Launch - review the instance configuration and click `"Launch"`.
- Select an existing key pair or create a new key pair to SSH into the Linux instance (skip this step if launching a Windows instance).

Step 4: Access the EC2 Instance
- Once the instance is launched, note down its public IP address or DNS name.
- For Windows instance `(IIS server)`:
- Use `Remote Desktop Protocol (RDP)` to connect to the instance using the provided Administrator credentials.
- Install IIS and deploy your ASP.NET web application.
- For Linux instance `(Amazon Linux)`:
- Use `SSH` to connect to the instance using the key pair.
- Install necessary packages (e.g., .NET Core runtime) and deploy your ASP.NET web application.

## Host an ASP.NET Web Application on Windows IIS Server using EC2 Instance
### Prerequisites:
- An EC2 instance running Windows Server with `Internet Information Services (IIS)` installed.
- ASP.NET web application files ready for deployment.

#### Steps:
- Connect to the `Windows EC2 Instance`:    
- Use `Remote Desktop Protocol (RDP)` to connect to the Windows EC2 instance.
- Enter the `public IP address` or `DNS name` of the EC2 instance along with the provided `Administrator credentials` to establish the remote desktop connection.
- Open `Internet Information Services (IIS)` Manager:
- Once connected to the EC2 instance, open `Internet Information Services (IIS) Manager`.
- You can find IIS Manager by searching for `"Internet Information Services (IIS) Manager"` in the `Start` menu.
- Create a `New Website` or `Virtual Directory`:
- In IIS Manager, expand the `server node` in the left-hand panel.
- Right-click on `"Sites"` and select `"Add Website"` to create a new website, or right-click on an existing website and select `"Add Virtual Directory"` to create a virtual directory within an existing site.
- Enter the necessary details such as site name, physical path (location of your ASP.NET web application files), and binding information (e.g., IP address, port, host name).
- *Configure Application Pool*:-
        In IIS Manager, navigate to "Application Pools" in the left-hand panel.
- Ensure that the `.NET CLR` version and pipeline mode of the application pool associated with your website or virtual directory are configured correctly based on the version of ASP.NET your application targets (e.g., .NET CLR version: v4.0, Managed pipeline mode: Integrated).
#### Deploy `ASP.NET Web Application`:

- Copy your `ASP.NET web application files` (including .aspx, .cs, .config files, etc.) to the physical path specified during website or virtual directory creation.
- Ensure that all necessary files and directories are included and properly configured.
- Configure IIS Settings:
- Depending on your application's requirements, configure various IIS settings such as `authentication, authorization, MIME types, URL rewrite rules, etc.`, to ensure proper functioning of the web application.
- You can configure these settings through features available in IIS Manager.
- Test the Hosted Web Application:
- Once the ASP.NET web application is deployed and configured in IIS, test its functionality by accessing it through a `web browser`.
- Enter the public IP address or DNS name of the EC2 instance along with the appropriate `port and site name` (if applicable) in the browser's address bar to access the web application.
- Ensure that the application loads without errors and performs as expected.
By following these steps, you can successfully host your ASP.NET web application on a Windows IIS server running on an AWS EC2 instance.

## Host an ASP.NET Web Application on Linux Server (Amazon Linux) using Apache HTTP Server (httpd):
### Prerequisites:
- An EC2 instance running Amazon Linux.
- ASP.NET web application files ready for deployment.
### Steps:

- Connect to the Linux EC2 Instance:
Step 1: Switch to Root User
```bash 
sudo su -
```
Purpose: This command switches the current user to the root user with superuser privileges. It allows you to execute subsequent commands as the root user, which is necessary for performing system-level tasks.

Step 2: Update System Packages
```bash
yum update -y
```
Purpose: This command updates all installed packages on the system using the YUM package manager. The -y flag automatically answers "yes" to any prompts, allowing the update process to proceed without requiring user input.

Step 3: Install Apache HTTP Server
```bash
yum install -y httpd
```
Purpose: This command installs the Apache HTTP Server package (httpd) on the system. Apache HTTP Server is a widely-used web server that can serve HTML files, static content, and dynamic content generated by server-side languages like PHP or ASP.NET.

Step 4: Check Apache HTTP Server Status
```bash
systemctl status httpd
```
Purpose: This command checks the status of the Apache HTTP Server service (httpd). It provides information about whether the service is active, its uptime, and any errors or warnings. This is useful for verifying that the service is running correctly after installation.

Step 5: Create a Temporary Directory
```bash
mkdir temp
cd temp
```
Purpose: These commands create a new directory named temp and change the current directory to temp. This directory will be used to store temporary files and downloaded content during the setup process.

Step 6: Download Web Application Files
```bash
wget https://www.free-css.com/assets/files/
```
Purpose: This command uses the wget utility to download files from the specified URL. In this case, it downloads a ZIP archive containing the ASP.NET web application files from the provided URL.

https://www.free-css.com/assets/files/free-css-templates/download/page28/inflight.zip

Step 7: Extract Web Application Files
```bash
unzip complex.zip
cd complex
```
Purpose: These commands unzip the downloaded ZIP archive and change the current directory to the extracted directory (complex). The extracted directory contains the ASP.NET web application files that will be deployed to the Apache HTTP Server.

Step 8: Move Web Application Files to Document Root
```bash
ls -lrt
mv * /var/www/html
```
Purpose: These commands list the files and directories in the current directory (ls -lrt) and move (mv) all files and directories (*) to the document root directory of Apache HTTP Server (/var/www/html). The document root is the directory from which Apache serves web content.

Step 9: Enable and Start Apache HTTP Server
```bash
systemctl enable httpd
systemctl start httpd
```
Purpose: These commands enable and start the Apache HTTP Server service (httpd). Enabling the service ensures that Apache starts automatically at system boot, while starting the service immediately makes Apache active and ready to serve web content.

Step 10: 
Configure Security Groups:
Ensure that the security group associated with your EC2 instance allows inbound traffic on port 80 (HTTP) to access your ASP.NET web application from the internet.

Step 11: Test the Hosted Web Application:
Open a web browser and navigate to the public IP address or domain name associated with your EC2 instance.
You should see your ASP.NET web application hosted on the Linux server using Apache HTTP Server.
By following these detailed steps, you can successfully host an ASP.NET web application on a Linux server (Amazon Linux) using Apache HTTP Server.

## Deploying an ASP.Net Web Application on Windows IIS Server using terraform
### Pre-requisites for Using Terraform in VS Code:
- Install Visual Studio Code: Download and install Visual Studio Code from the official website: Visual Studio Code
- Install Terraform Extension: Open Visual Studio Code, go to the Extensions view by clicking on the square icon on the sidebar or pressing Ctrl+Shift+X. Search for "Terraform" and install the official Terraform extension by HashiCorp.
- Install Terraform: Download and install Terraform on your local machine. You can download it from the Terraform website and follow the installation instructions.
- AWS Account: You'll need an AWS account to create resources using Terraform. Sign up for an AWS account if you don't have one already.
- AWS Access Key and Secret Key: Generate an AWS Access Key ID and Secret Access Key from the AWS Management Console. Make sure to keep these credentials secure.

### Creating an EC2 Instance Using Terraform:
Step-1:-Set Up Terraform Configuration:
Create a directory for your Terraform configuration files.
Create a ec2_provider.tf file and add the following content to configure the AWS provider:
```
provider "aws" {
  region = "ap-south-1"
}
```

Step-2:- Create an ec2.tf file and add the following content to define the EC2 instance:
```
resource "aws_instance" "web" {
  ami           = "ami-07ef4004db979fcd4"  # Windows Server AMI ID
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld!!"
  }
}
```
Step-3:- Initialize Terraform: Open VS Code in the directory containing your Terraform configuration files. Open the integrated terminal and run the following command to initialize Terraform:
```bash
terraform init
```

Step-4:-Review and Apply Changes: Run the following command to preview the changes Terraform will make:
```bash
terraform plan
```

Step-5:-If everything looks good, apply the changes by running:
```bash
terraform apply
```
Enter "yes" when prompted to confirm.

Step-6:- To avoid incurring charges, destroy the deployed resources after testing:

```bash
terraform destroy
```

### Deploying and Testing ASP.NET Web Application on Windows IIS Server:

Step-1:-Connect to the EC2 Instance:
Once the EC2 instance is created, connect to it using Remote Desktop Protocol (RDP) or AWS Systems Manager Session Manager.


Step-2:-Install IIS:
Open PowerShell on the EC2 instance and run the following command to install IIS:
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

Step-3:-Deploy ASP.NET Web Application:
Copy your ASP.NET web application files to the appropriate directory on the EC2 instance (typically under C:\inetpub\wwwroot\).

Step-4:-Test the Web Application:
Open a web browser and navigate to the public IP address or DNS name of your EC2 instance to test your ASP.NET web application.

### Additional Resources:-
[Terraform documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

[AWS documentation](https://docs.aws.amazon.com/)

## Deploying an ASP.Net Web Application on Linux Server(Amazon Linux)using Apache httpd with terraform and configure it behind an Elastic Load Balancer.

### Steps to Deploy ASP.NET Web Application on Linux Server with Terraform:

Step-1:-Set Up Terraform Configuration:
Create a directory for your Terraform configuration files.
Create a `linux_provider.tf` file and add the following content to configure the AWS provider:
```bash
provider "aws" {
  region = "ap-south-1"
}
```

Step-2:-Create an `linux_ec2.tf` file and add the following content to define the Linux EC2 instance with httpd (Apache) installed:
```
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"
  
  user_data = <<-EOF
    #!/bin/bash
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
  EOF
  
  tags = {
    Name = "ASP.NET Web App Server"
  }
}
```
This code will install and start the Apache web server (httpd) on the EC2 instance.


Step-3:-Create Elastic Load Balancer (ELB):
Add the following code to the Terraform configuration to create an Elastic Load Balancer:
```
resource "aws_lb" "example" {
  name               = "example-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.example.id]
  subnets            = [aws_subnet.example_public.id, aws_subnet.example_private.id]
}
```
This code defines an Application Load Balancer (ALB) with security groups and subnets specified.

Step-4:-Deploy ASP.NET Web Application:
Copy your ASP.NET web application files to the appropriate directory on the EC2 instance (typically /var/www/html/).

Step-5:-Test the Web Application:
Open a web browser and navigate to the DNS name or IP address of the Elastic Load Balancer to test your ASP.NET web application.

## Implementing Load Balancer, VPC, Subnets, Route Tables, and EC2 Instances manually using the AWS Management Console:

Step-1:- Create a VPC:

- Go to the `Amazon VPC console`.
- Click on `"Create VPC"`
- Provide the `CIDR block (e.g., 10.0.0.0/16)` and optionally add tags.
- Click on `"Create VPC."`

Step-2:-Create Subnets:
- Go to the `Amazon VPC console.`
- Click on `"Subnets"` in the left navigation pane.
- Click on `"Create subnet."`
- Select the VPC you created earlier.
- Provide a `name, CIDR block, and availability zone for the subnet`.
- Click on "Create subnet."
- Repeat this process to create additional subnets as needed.

Step-3:-Create an Internet Gateway (IGW):
- Go to the `Amazon VPC console`.
- Click on `"Internet Gateways"` in the left navigation pane.
- Click on `"Create internet gateway."`
- Provide a name for the internet gateway.
- Click on `"Create internet gateway."`
- Select the newly created internet gateway and click on`"Attach to VPC."`
- Choose the VPC you created earlier and click on "Attach internet gateway."

Step-4:-Create Route Tables:
- Go to the `Amazon VPC console.`
- Click on `"Route Tables"` in the left navigation pane.
- Click on `"Create route table."`
- Provide a name for the route table and select the VPC.
- Click on `"Create route table."`
- Select the route table and click on the `"Routes"` tab.
- Click on `"Edit routes"` and add a route for internet traffic (0.0.0.0/0) pointing to the internet gateway created earlier.
- Click on `"Save routes"`.

Step-5:-Associate Subnets with Route Tables:
- Go to the `Amazon VPC console.`
- Click on `"Route Tables"` in the left navigation pane.
- Select the `route table` you created earlier.
- Click on the `"Subnet associations"` tab.
- Click on `"Edit subnet associations"` and select the subnets to associate with the route table.
- Click on `"Save."`

Step-6:-Create EC2 Instances:
- Go to the `Amazon EC2 console.`
- Click on `"Launch instance."`
- Choose an `Amazon Machine Image (AMI), instance type, configure instance details (e.g., network, subnet), add storage, configure security groups`, and review.
- Click on `"Launch."`
- Select an existing key pair or create a new one, acknowledge, and click on `"Launch instances."`

Step-7:-Create a Load Balancer (Optional):
- Go to the `Amazon EC2 console.`
- Click on `"Load Balancers"` in the left navigation pane.
- Click on `"Create Load Balancer."`
- Choose a load balancer type (e.g., Application Load Balancer, Network Load Balancer, Classic Load Balancer).
- Configure the `load balancer settings, listeners, security settings, subnets, and routing configuration.`
- Review and create the load balancer.
By following these steps, you can manually set up a VPC, subnets, route tables, and EC2 instances using the AWS Management Console. Optionally, you can also create a load balancer to distribute traffic across multiple instances.

## Implementing Load Balancer, VPC, Subnets, Route Tables, and EC2 Instances manually using the Terraform

This Terraform script automates the deployment of Linux instances behind an AWS Application Load Balancer (ALB). It sets up the necessary infrastructure components, including VPC, subnets, security groups, ALB, target groups, and EC2 instances. The deployed instances run a basic web server using Apache HTTP Server to serve web content.



#### Step 1: alb.tf - Application Load Balancer Configuration

```
resource "aws_lb_target_group" "tg" {
  health_check {
    interval            = "10"
    path                = "/"
    protocol            = "HTTP"
    timeout             = "5"
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
  }
  name         = "target-group"
  port         = "80"
  protocol     = "HTTP"
  target_type  = "instance"
  vpc_id       = aws_vpc.vpc.id
}

```

* Configures an AWS Application Load Balancer (ALB) to distribute incoming traffic across EC2 instances.
* Specifies the ALB's name, type, subnets, security groups, and tags for identification.
* Sets up a listener to forward HTTP requests from port 80 to the associated target group.

#### Step-2:internet_gateway.tf - Internet Gateway Configuration

```
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "IGWLoadbalancer"
  }
}

```
* Defines an AWS Internet Gateway and associates it with the VPC to enable internet connectivity for instances.
* Adds tags to label the Internet Gateway for better management and identification within the infrastructure.
* Establishes the connection between the VPC and the Internet Gateway to facilitate outbound internet access.
#### Step-3:instances.tf - EC2 Instances Configuration

```
resource "aws_instance" "ec2" {
  ami = "ami-013e83f579886baeb"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet1.id
  user_data = file("shell.sh")
  vpc_security_group_ids = [aws_security_group.sgforinstance.id]
  tags = {
    Name = "LB-EC2"
  }
}
resource "aws_instance" "ec21" {
  ami = "ami-013e83f579886baeb"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet1.id
  user_data = file("shell.sh")
  vpc_security_group_ids = [aws_security_group.sgforinstance.id]
  tags = {
    Name = "LB-EC21"
  }
}


```

* Creates EC2 instances with specified AMI, instance type, subnet, security group, and user data script.
* Tags the instances for identification and categorization within the AWS environment.
* Sets up Apache HTTP Server on the instances using the provided user data script (shell.sh) for serving web content.

#### Step-4:shell.sh - User Data Script

```
#!/bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo "<h1>Hello from$(hostname)</h1>" > /var/www/html/index.html

```

* Bash script executed during instance initialization to install and configure Apache HTTP Server.
* Installs necessary packages, starts the HTTP service, and enables it to run automatically on system boot.
* Creates a basic HTML file with a hostname tag to serve as the web content for the deployed instances.

#### Step-5:load_balancer.tf - Load Balancer Configuration
```
resource "aws_lb" "application-lb" {
  name = "aws-alb"
  internal = false
  ip_address_type = "ipv4"
  load_balancer_type = "application"
  security_groups = [aws_security_group.sgforloadbalancer.id]
  subnets = [aws_subnet.subnet1.id,aws_subnet.subnet2.id]
  tags = {
    Name = "aws-alb"
  }
}

```

* Defines an AWS Application Load Balancer (ALB) with specified attributes such as name, type, subnets, and security groups.
* Ensures proper routing of incoming HTTP requests to target instances using a configured target group.
* Adds tags for easy identification and management of the ALB within the AWS environment.
#### Step-6:output.tf - Output Configuration

```
output "aws_lb_arn" {
  value = aws_lb.application-lb.id
}

output "aws_lb_pub_dns" {
  value = aws_lb.application-lb.dns_name
}

```

* Specifies outputs to display after Terraform execution, including the ALB's ARN and public DNS name.
* Provides essential information for accessing the deployed infrastructure components, facilitating post-deployment tasks.
* Enables users to easily identify and utilize the created resources for further configurations or integrations.

#### Step-7:subnet.tf - Subnet Configuration

```
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  cidr_block             = "10.0.0.0/25"
  tags = {
    Name = "Loadbalancer_subnet_1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
  cidr_block             = "10.0.0.128/25"
  tags = {
    Name = "Loadbalancer_subnet_2"
  }
}


```

* Defines subnets within the VPC, specifying the CIDR block, availability zone, and enabling public IP mapping.
* Tags the subnets for identification and categorization, enhancing manageability in a multi-subnet environment.
* Ensures proper network segmentation and resource placement across different availability zones for fault tolerance.

#### Step-8:target_group_attachment.tf - Target Group Attachment Configuration

```
resource "aws_lb_target_group_attachment" "tg-attach" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.ec2.id
}

resource "aws_lb_target_group_attachment" "tg-attach1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.ec21.id
}


```
* Attaches EC2 instances to the specified target group within the ALB configuration.
* Associates instances with the ALB to receive and process incoming HTTP requests.
* Ensures proper load distribution and high availability by distributing traffic across multiple instances.

#### Step-9:vpc.tf - VPC Configuration

```
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "Loadbalancer_VPC"
  }
}


```

* Sets up an AWS Virtual Private Cloud (VPC) with a defined CIDR block for private networking.
* Adds tags to label the VPC for better organization and management of cloud resources.
* Creates a secure and isolated network environment for deploying EC2 instances and other AWS resources.

### Testing


* Obtain the DNS name of your load balancer from the Terraform output.
* Open a web browser and navigate to the load balancer's DNS name.
* Verify that the application loads successfully in the browser.
* Monitor traffic distribution across instances for load balancing effectiveness.


### CONCLUSION

The deployment of the application on AWS with load balancing has been successfully configured and tested. Accessing the application through the load balancer's DNS name confirms its functionality, while monitoring ensures effective traffic distribution across instances, validating the robustness of the setup.
