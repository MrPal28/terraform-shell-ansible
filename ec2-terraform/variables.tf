variable "ec2_instance_type" {
  default = "t2.micro"
  type = string
}

variable "ec2_default_storage_size"{
  default = 8
  type = number
}

variable "ec2_storage_type"{
  default = "gp3"
  type =string
}

variable "ec2_ami"{
  default = "ami-01a00762f46d584a1"
  type = string
}

variable "ec2_instance_count"{
  default = 1
  type = number
}

variable "environment"{
  default = "dev"
  type = string
}