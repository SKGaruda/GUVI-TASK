#!/bin/bash

# Update packages
dnf update -y

# Install nginx
dnf install -y nginx

# Enable nginx at boot
systemctl enable nginx

# Start nginx
systemctl start nginx

# Create a custom page
cat > /usr/share/nginx/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Terraform Nginx Server</title>
</head>
<body>
    <h1>Nginx is running!</h1>
    <p>Server created using Terraform.</p>
</body>
</html>
EOF
