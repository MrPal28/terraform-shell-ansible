resource "aws_vpc" "xfusion-vpc"{
    cidr_block = "192.168.0.0/24"

    tags = {
        Name = "xfusion-vpc"
    }
}