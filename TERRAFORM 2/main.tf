# -------------------------
# Get default VPC - Virginia
# -------------------------

data "aws_vpc" "virginia" {
  provider = aws.virginia

  default = true
}

# -------------------------
# Get default subnet - Virginia
# -------------------------

data "aws_subnets" "virginia" {
  provider = aws.virginia

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.virginia.id]
  }
}

# -------------------------
# Get latest Amazon Linux 2023 AMI - Virginia
# -------------------------

data "aws_ssm_parameter" "al2023_virginia" {
  provider = aws.virginia

  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# -------------------------
# Get default VPC - Mumbai
# -------------------------

data "aws_vpc" "mumbai" {
  provider = aws.mumbai

  default = true
}

# -------------------------
# Get default subnet - Mumbai
# -------------------------

data "aws_subnets" "mumbai" {
  provider = aws.mumbai

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.mumbai.id]
  }
}

# -------------------------
# Get latest Amazon Linux 2023 AMI - Mumbai
# -------------------------

data "aws_ssm_parameter" "al2023_mumbai" {
  provider = aws.mumbai

  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}


# =========================================================
# SECURITY GROUP - VIRGINIA
# =========================================================

resource "aws_security_group" "nginx_virginia" {
  provider = aws.virginia

  name        = "nginx-sg-virginia"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.virginia.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# =========================================================
# SECURITY GROUP - MUMBAI
# =========================================================

resource "aws_security_group" "nginx_mumbai" {
  provider = aws.mumbai

  name        = "nginx-sg-mumbai"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.mumbai.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# =========================================================
# EC2 - VIRGINIA
# =========================================================

resource "aws_instance" "nginx_virginia" {
  provider = aws.virginia

  ami = data.aws_ssm_parameter.al2023_virginia.value

  instance_type = var.instance_type

  subnet_id = data.aws_subnets.virginia.ids[0]

  vpc_security_group_ids = [
    aws_security_group.nginx_virginia.id
  ]

  user_data = file("${path.module}/userdata.sh")

  associate_public_ip_address = true

  tags = {
    Name = "nginx-server-virginia"
  }
}


# =========================================================
# EC2 - MUMBAI
# =========================================================

resource "aws_instance" "nginx_mumbai" {
  provider = aws.mumbai

  ami = data.aws_ssm_parameter.al2023_mumbai.value

  instance_type = var.instance_type

  subnet_id = data.aws_subnets.mumbai.ids[0]

  vpc_security_group_ids = [
    aws_security_group.nginx_mumbai.id
  ]

  user_data = file("${path.module}/userdata.sh")

  associate_public_ip_address = true

  tags = {
    Name = "nginx-server-mumbai"
  }
}
