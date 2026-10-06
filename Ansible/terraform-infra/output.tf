output "public_ip" {
  value = aws_instance.ec2_automated_server[*].public_ip
}
