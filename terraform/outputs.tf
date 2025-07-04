output "ec2_public_ip" {
  value = aws_instance.web.public_ip
  description = "The public IP of the EC2 instance"
}