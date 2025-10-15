provider "aws" {
    alias = "asia_south_1"
    region = "ap-south-1"
  
} 


resource "aws_instance" "ec2" {
    ami = "ami-02d26659fd82cf299"
    instance_type = "t2.micro"
    security_groups = ["all-trafiic"]
    key_name = "linux"
    tags = {
      Name = "provisnor"
    }
provisioner "file" {
    source = "index.html"
    destination = "/tmp/index.html"
  
}
provisioner "remote-exec"{
    inline = [
        "sudo apt update -y",
        "sudo apt install nginx -y",
        "sudo cp /tmp/index.html /var/www/html/index.html",
        "sudo systemctl restart nginx",
        "sudo systemctl enable nginx"
    ]
}
connection {
  host = self.public_ip
  user = "ubuntu"
  type = "ssh"
  private_key = file("C:/Users/abhi8/Downloads/linux.pem")
}

  
}