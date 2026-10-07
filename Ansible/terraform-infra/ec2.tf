

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_http_https"
  description = "Allow SSH Access"
  vpc_id      = aws_default_vpc.default.id

  #inbound rule
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH ACCESS"
  }
  #outbound rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    name = "allow_ssh"
  }
}

# EC2 Instance

resource "aws_instance" "ec2_automated_server" {
  # for_each = tomap({
  #     AWS_EC2_1 = "t2.micro"
  #     AWS_EC2_2 = "t3.micro"
  # })

  depends_on = [aws_security_group.allow_ssh, aws_key_pair.terraform_key]

  count           = 2 #Meta Argument to create multiple instances
  key_name        = "agneesh_key_pair"
  security_groups = [aws_security_group.allow_ssh.name]
  instance_type   = "t2.micro"
  ami             = "ami-01a00762f46d584a1"

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name = "worker-node-${count.index + 1}"
  }
}
