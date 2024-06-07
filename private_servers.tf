resource "aws_instance" "private_server" {
  ami                         = var.private_ami_image
  instance_type               = "t2.small"
  availability_zone           = var.availability_zone1
  subnet_id                   = aws_subnet.private.id
  vpc_security_group_ids      = [aws_security_group.private.id]
  associate_public_ip_address = false

  depends_on = [aws_subnet.private, aws_security_group.private]
  user_data  = file("bash/private_server.bash")
  tags = {
    Name = "server.mydomain.priv"
  }
  root_block_device {
    volume_size           = 50    # Size in GB
    volume_type           = "gp2" # General Purpose SSD
    delete_on_termination = true  # Delete volume on instance termination
    encrypted             = false # Whether the volume should be encrypted
  }
}
