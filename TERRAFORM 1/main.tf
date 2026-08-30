terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.5.0"
}

# --------------------------------------------------
# AWS Provider - Region 1
# --------------------------------------------------

provider "aws" {
  alias  = "region1"
  region = "us-east-1"
}

# --------------------------------------------------
# AWS Provider - Region 2
# --------------------------------------------------

provider "aws" {
  alias  = "region2"
  region = "us-west-2"
}

# --------------------------------------------------
# EC2 Instance - Region 1
# --------------------------------------------------

resource "aws_instance" "linux_region1" {
  provider = aws.region1

  ami           = "ami-0332d564d76dbd8d6"
  instance_type = "t2.micro"

  tags = {
    Name = "Linux-EC2-us-east-1"
  }
}

# --------------------------------------------------
# EC2 Instance - Region 2
# --------------------------------------------------

resource "aws_instance" "linux_region2" {
  provider = aws.region2

  ami           = "ami-08b7b9fdd7a1edf3d"
  instance_type = "t2.micro"

  tags = {
    Name = "Linux-EC2-us-west-2"
  }
}
