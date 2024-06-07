resource "aws_instance" "public_server" {
  ami                         = var.public_ami_image
  instance_type               = "t2.micro"
  availability_zone           = var.availability_zone1
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.private.id]
  associate_public_ip_address = true
  depends_on                  = [aws_subnet.private, aws_security_group.private]
  user_data                   = file("bash/public_server.bash")
  tags = {
    Name = "server.mydomain.com"
  }
}
