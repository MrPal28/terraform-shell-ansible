resource "aws_default_vpc" "default" {
}

resource "aws_security_group" "nautilus-sg" {
    name = "nautilus-sg"
    description = "Security group for Nautilus App Servers"
    vpc_id = aws_default_vpc.default.id

    ingress {
        from_port = 80
        to_port = 80 
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}