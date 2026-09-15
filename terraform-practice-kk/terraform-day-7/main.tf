

resource "tls_private_key" "datacenter_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
resource "local_file" "private_key" {
  content         = tls_private_key.datacenter_key_pair.private_key_pem
  filename        = "datacenter-kp.pem"
  file_permission = "0600"
}
resource "aws_key_pair" "datacenter_kp" {
  key_name   = "datacenter-kp"
  public_key = tls_private_key.datacenter_key_pair.public_key_openssh
}

resource "aws_default_vpc" "default" {
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_default_vpc.default.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "datacenter_ec2" {

  ami                    = "ami-0e34b50e714a297f1"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.datacenter_kp.key_name
  vpc_security_group_ids = [aws_default_security_group.default.id]

#   root_block_device {
#     volume_size = 8
#     volume_type = "gp3"
#   }

  tags = {
    Name = "datacenter-ec2"
  }
}