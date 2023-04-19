terraform {
required_providers {
aws = {
source = "hashicorp/aws"
version = "~> 4.0"
}
}
}
variable "accesskey" {}
variable "secretkey" {}
provider "aws" {
region= "ap-south-1"
access_key = var.accesskey
secret_key = var.secretkey
}
variable "region_name" {
type=string
default= "ap-south-1"
}
variable "server_port" {
type= number
default=80
}
variable "publiccidr" {
type = list(string)
default = ["0.0.0.0/0"]
}
resource "aws_instance" "myec2" {
  ami                    = "ami-0d81306eddc614a45"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ownsg.id]
  key_name               = "tf-key-pair"
  tags = {
    Name = "terraform-example"
  }
  user_data = <<-EOF
#!/bin/bash
yum install httpd -y
service httpd start
cd /var/www/…
