# Configure AWS provider
provider "aws" {
  region = "ap-south-1"
}

# Create EC2 instance
resource "aws_instance" "web" {
  ami           = "ami-001843b876406202a"  # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"
  tags = {
    Name = "ASP.NET Web App Server"
  }

  # Connection configuration for provisioner
  connection {
    type       = "ssh"
    user       = "ec2-user"
    private_key = file("D:/AdTech/Tasks/linux.pem")  
    host       = self.public_ip
    timeout    = "3m"  # Timeout set to 3 minutes
  }

  # Provision script to install and start Apache HTTP Server
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]
  }
}

# Create security group for EC2 instance
resource "aws_security_group" "instance_sg" {
  name        = "web_server_linux_sg"
  description = "Security group for web server instance"

  # Ingress rule to allow HTTP traffic
  ingress {
    from_port = 80
    to_port   = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rule to allow all outbound traffic
  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create load balancer
resource "aws_lb" "example" {
  name                 = "example-lb"
  internal             = false
  load_balancer_type    = "application"
  security_groups       = [aws_security_group.instance_sg.id]

  # Subnets where the load balancer will be deployed
  subnets = ["subnet-088bea88e04382187", "subnet-0e8ff249fe0665543"]  

  # Health check configuration
  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true

  tags = {
    Name = "Example Load Balancer"
  }
}

# Output EC2 instance ID and Load Balancer DNS name
output "instance_id" {
  value = aws_instance.web.id
}

output "load_balancer_dns_name" {
  value = aws_lb.example.dns_name
}
