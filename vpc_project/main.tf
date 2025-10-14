provider "aws" {
    alias = "asia_south_1"
    region = "ap-south-1"
  
} 

resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "TestVPC"
    }
  
}

resource "aws_security_group" "sg" {
    
    name = "test_sg"
    description = "Allow all inbound and outbound traffic"
    vpc_id = aws_vpc.vpc.id
    ingress {
        protocol  = "-1"
        from_port = 0
        to_port   = 0
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_subnet" "subnet1" {

    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    tags = {
      Name = "Public Subnet"
    }
  
}

resource "aws_subnet" "subnet2" {

    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.2.0/24"
    tags = {
      Name = "Private Subnet"
    }
  
}

resource "aws_eip" "nat_eip" {
    domain = "vpc"
    tags = {
      Name = "NAT EIP"
    }
  
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.subnet1.id

    tags = {
      Name = "TestNAT"
    }

  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "test-igw"
    }
  
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      Name = "Public RT"
    }
  
}

resource "aws_route_table_association" "public_rta" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.public_rt.id
  
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
      Name = "Private RT"
    }
  
}

resource "aws_route_table_association" "private_rta" {
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.private_rt.id
  
}


resource "aws_instance" "public_vm" {
    ami = "ami-01b6d88af12965bb6"
    instance_type = "t3.micro"
    key_name = "linux"
    security_groups = [aws_security_group.sg.id]
    subnet_id = aws_subnet.subnet1.id
    tags = {
      name = "PublicInstance"
    }
  
}

resource "aws_instance" "private_vm" {
    ami = "ami-01b6d88af12965bb6"
    instance_type = "t2.micro"
    key_name = "linux"
    security_groups = [aws_security_group.sg.id]
    subnet_id = aws_subnet.subnet2.id
    tags = {
      name = "PrivateInstance"
    }
  
}