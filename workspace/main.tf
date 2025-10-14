provider "aws" {
    alias = "asia_south_1"
    region = "ap-south-1"
  
} 

variable "tag" {
    type = string
  
}

resource "aws_instance" "public_vm" {
    ami = "ami-01b6d88af12965bb6"
    instance_type = "t2.micro"
    key_name = "linux"
    tags = {
      Name = var.tag
    }
  
}