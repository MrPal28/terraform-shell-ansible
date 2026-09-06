output "ec2_public_ip"{
  value = aws_instance.ec2_automated_server.public_ip
}
output "ec2_public_dns"{
  value = aws_instance.ec2_automated_server.public_dns
}

