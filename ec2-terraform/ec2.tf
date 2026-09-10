# File Path: ec2-terraform/ec2.tf
# VPC & Security Group

resource "aws_default_vpc" "default"{

}

resource "aws_security_group" "allow_ssh"{
    name        = "allow_ssh_http_https"
    description = "Allow SSH Access"
    vpc_id = aws_default_vpc.default.id

    #inbound rule
    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH ACCESS"
    }
    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP ACCESS"
    }

    ingress{
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTPS Access"
    }
    #outbound rule
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
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

    count = var.ec2_instance_count #Meta Argument to create multiple instances
    key_name = aws_key_pair.terraform_key.key_name
    security_groups = [aws_security_group.allow_ssh.name]
    instance_type = each.value
    ami = var.ec2_ami
    user_data = file("nginx_install.sh")

    root_block_device{
        volume_size = environment == "dev" ? var.ec2_default_storage_size : 16
        volume_type = var.ec2_storage_type
    }   

    tags = {
        Name = each.key
    }
}