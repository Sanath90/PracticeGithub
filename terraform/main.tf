resource "tls_private_key" "tls_key"{
    algorithm = "RSA"
      lifecycle {
    create_before_destroy = true
  }
}

resource "aws_key_pair" "ec2_key" {
  key_name = "ec2-key1"
  public_key = tls_private_key.tls_key.public_key_openssh
}

resource "aws_instance" "example" {
  ami           = "ami-04b4f1a9cf54c11d0"  # Required: Specify an AMI ID
  instance_type = "t2.micro"              # Required: Specify instance type

  # Optional but recommended:
  key_name      = aws_key_pair.ec2_key.key_name               # SSH key to access the instance
  subnet_id     = "subnet-0264f8d8f5b2ecff8"         # Subnet where the instance is launched
  security_groups = ["sg-040898efc2a69c61f"]       # Security groups for network rules
}


# Output private key (store it in a local file)
resource "local_file" "private_key_pem" {
  content  = tls_private_key.tls_key.private_key_pem
  filename = "ec2-key.pem"
}

# Terraform output (for GitHub Actions)
output "private_key_path" {
  value = "ec2-key.pem"
}