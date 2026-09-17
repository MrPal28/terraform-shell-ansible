resource "aws_ebs_volume" "xfusion_volume" {
  availability_zone = "us-east-1"
  size              = 2
  type              = "gp3"

  tags = {
    Name = "xfusion-volume"
  }
}
