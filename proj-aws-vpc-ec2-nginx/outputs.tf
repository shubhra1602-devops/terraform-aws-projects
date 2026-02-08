output "instance_public_IP" {
    description = "The Public IP of the EC2 Instance"
    value       = aws_instance.nginxserver.public_ip
}

output "instance_URL" {
    description = "The URL to the NGINX server"
    value       = "http://${aws_instance.nginxserver.public_ip}"
  
}