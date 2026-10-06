resource "tls_private_key" "terraform_key"{
    algorithm = "RSA"
    rsa_bits =2048
}
resource "local_file" "private_key"{
    content = tls_private_key.terraform_key.private_key_pem
    filename = "terraform-key-ec2.pem"
    file_permission = "0600"
}
resource "aws_key_pair" "terraform_key"{
    key_name = "terraform-key-ec2"
    public_key = tls_private_key.terraform_key.public_key_openssh
}
