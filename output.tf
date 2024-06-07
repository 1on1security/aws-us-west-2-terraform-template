output "public_server_IP_Address" {
  value = aws_instance.public_server.public_ip
}
output "private_server_IP_Address" {
  value = aws_instance.private_server.private_ip
}