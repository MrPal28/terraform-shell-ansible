output "ec2_public_ip"{
  value = aws_instance.ec2_automated_server[var.ec2_instance_count - 1].public_ip
}
output "ec2_public_dns"{
  value = aws_instance.ec2_automated_server[var.ec2_instance_count - 1].public_dns
}

