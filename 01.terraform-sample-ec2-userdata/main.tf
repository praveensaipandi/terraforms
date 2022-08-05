provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = "ami-08d4ac5b634553e16"
  instance_type          = "t2.micro"
  key_name               = "tf"
  monitoring             = true
  vpc_security_group_ids = ["sg-0d61ae64f8f0f6bcc"]
  subnet_id              = "subnet-080f786fc7313bb62"

  
  tags = {
    Name = "terraform-instance"
    Terraform   = "true"
    Environment = "dev"
  }
}

terraform {
  backend "s3" {
    encrypt = true
    bucket = "srimanoutput"
    region = "us-east-1"
    key = "terraform-state/terraform.tfstate"
  }
}
