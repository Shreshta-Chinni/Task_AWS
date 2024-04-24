resource "aws_instance" "web" {
  ami           = "ami-07ef4004db979fcd4"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld!!"
  }
}
