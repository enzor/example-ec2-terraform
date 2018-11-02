variable "profile" {
  default = "default"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.0.0/24"
}

variable "target_ami" {
  default = "ami-0735ea082a1534cac"
}
