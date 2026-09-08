# For this task, create a key pair using Terraform with the following requirements:

# Name of the key pair should be devops-kp.

# Key pair type must be rsa.

# The private key file should be saved under /home/bob/devops-kp.pem.

resource "tls_private_key" "xfusion_kp" {
algorithm = "RSA"
rsa_bits = 2048
}

resource "local_file" "private_key" {
content = tls_private_key.xfusion_kp.private_key_pem
filename = "/home/bob/xfusion-kp.pem"
file_permission = "0600"
}
resource "aws_key_pair" "xfusion_kp" {
key_name = "xfusion-kp"
public_key = tls_private_key.xfusion_kp.public_key_openssh
}