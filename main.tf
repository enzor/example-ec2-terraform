resource "aws_instance" "web" {
  ami           = "${var.target_ami}"
  instance_type = "t2.medium"
  subnet_id = "${aws_subnet.eu-east-1a-public.id}"
  vpc_security_group_ids = [
      "${aws_security_group.instance_sg.id}"
  ]

  tags {
    Name = "HelloWorld"
  }
}