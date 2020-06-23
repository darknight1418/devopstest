provider "aws" {
    region = "eu-west-2"
    shared_credentials_file = "nofile.txt"
}
resource "aws_vpc" "vpctmp" {    
    cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "subnettmp" {
  vpc_id     = aws_vpc.vpctmp.id
  cidr_block = "10.0.0.0/16"
}
resource "aws_security_group" "sgViews" {
  name        = "Frontend Security Group"
  description = "SG to allow incoming traffic to the view instance"
  vpc_id      = aws_vpc.vpctmp.id
   ingress {
    description = "Inbound http traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
   ingress {
    description = "Inbound https traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"    
    cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
    description = "Inbound ssh traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"    
    cidr_blocks = ["0.0.0.0/0"]
    }
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "sgControllers" {
  name        = "Bakcend Security Group"
  description = "SG to only allow ssh incoming traffic"
  vpc_id      = aws_vpc.vpctmp.id
  ingress {
    description = "Inbound ssh traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"    
    cidr_blocks = [aws_vpc.vpctmp.cidr_block]
  }
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "live_view_ec2_instance" {
    ami = "kpmg_views_ami"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.sgViews.id]
    subnet_id = aws_subnet.subnettmp.id
}
resource "aws_instance" "live_controller_ec2_instance" {
    ami = "kpmg_controllers_ami"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.sgControllers.id]
    subnet_id = aws_subnet.subnettmp.id
}
resource "aws_db_instance" "live_database" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "devopsdb"
  username             = "devopsdbuser"
  password             = "somepassword$"
}