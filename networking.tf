resource "aws_vpc" "instance_vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "instance-vpc"
    }
}


resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.instance_vpc.id}"
}

resource "aws_subnet" "eu-east-1a-public" {
    vpc_id = "${aws_vpc.instance_vpc.id}"
    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "${var.aws_region}a"

    tags {
        name = "Test machine"
    }
}


resource "aws_route_table" "eu-east-1a-public" {
  vpc_id = "${aws_vpc.instance_vpc.id}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
      Name = "Public Subnet"
  }
}


resource "aws_route_table_association" "us-east-1a-public" {
    subnet_id = "${aws_subnet.eu-east-1a-public.id}"
    route_table_id = "${aws_route_table.eu-east-1a-public.id}"
}


resource "aws_security_group" "instance_sg" {
    name = "instance_sg"
    description = "allow incoming connection"
    vpc_id = "${aws_vpc.instance_vpc.id}"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
