output "virginia_instance_id" {
  description = "Virginia EC2 instance ID"
  value       = aws_instance.nginx_virginia.id
}

output "virginia_public_ip" {
  description = "Virginia EC2 public IP"
  value       = aws_instance.nginx_virginia.public_ip
}

output "virginia_nginx_url" {
  description = "Virginia Nginx URL"
  value       = "http://${aws_instance.nginx_virginia.public_ip}"
}


output "mumbai_instance_id" {
  description = "Mumbai EC2 instance ID"
  value       = aws_instance.nginx_mumbai.id
}

output "mumbai_public_ip" {
  description = "Mumbai EC2 public IP"
  value       = aws_instance.nginx_mumbai.public_ip
}

output "mumbai_nginx_url" {
  description = "Mumbai Nginx URL"
  value       = "http://${aws_instance.nginx_mumbai.public_ip}"
}
