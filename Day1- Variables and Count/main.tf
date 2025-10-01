provider "aws" {
    alias = "asia_south_1"
    region = "ap-south-1"
  
} 

resource "aws_instance" "vm_1" {
    count = 2
    ami = var.image_id
    instance_type = var.instance_type[count.index]
    tags = {
      Name = var.tag[count.index]
    }
}




