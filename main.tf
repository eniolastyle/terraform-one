terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
    backend "s3" {
      bucker = var.s3_bucket_name
      key    = "aws/terraform1/terraform.tfstate"
      region = var.region
    }
  }
}

provider "aws" {
  profile = "eniaccess"
  region  = "us-east-1"
}

# Provision the ec2 instance for NGINX
resource "aws_instance" "nginx-server" {
  ami                    = "ami-0aa2b7722dc1b5612"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.ec2-server.key_name
  vpc_security_group_ids = [aws_security_group.general-sg.id]
  user_data              = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install apache2 -y
                sudo systemctl start nginx
                sudo systemctl enable nginx
                EOF

  tags = {
    "Name" = "nginx-server"
  }
}

# Provision the ec2 instance for APACHE
resource "aws_instance" "apache-server" {
  ami                    = "ami-0aa2b7722dc1b5612"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.ec2-server.key_name
  vpc_security_group_ids = [aws_security_group.general-sg.id]
  user_data              = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install nginx -y
                sudo systemctl start apache2
                sudo systemctl enable apache2
                EOF

  tags = {
    "Name" = "nginx-server"
  }
}

resource "aws_lb" "terraform-one" {
  name               = "terraform-one-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.general-sg.id]
  subnets            = aws_subnet.subnet.*.id
}

resource "aws_lb_target_group" "terraform-one" {
  name        = "terraform-one-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "vpc-0840aafd81290a9aa"

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "terraform-one" {
  load_balancer_arn = aws_lb.terraform-one.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terraform-one.arn
  }
}

resource "aws_lb_target_group_attachment" "nginx-server" {
  target_group_arn = aws_lb_target_group.terraform-one.arn
  target_id        = aws_instance.nginx-server.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "apache-server" {
  target_group_arn = aws_lb_target_group.terraform-one.arn
  target_id        = aws_instance.apache-server.id
  port             = 80
}

resource "aws_security_group" "general-sg" {
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]

  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "allow ssh"
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 22
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "allow http"
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
  }]
}

resource "aws_key_pair" "ec2-server" {
  key_name   = var.key_name
  public_key = var.public_key
}

