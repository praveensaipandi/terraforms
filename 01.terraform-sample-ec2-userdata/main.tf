provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = "ami-08d4ac5b634553e16"
  instance_type          = "t2.micro"
  key_name               = "terraforms"
  monitoring             = true
  vpc_security_group_ids = ["sg-02f7c446fdf08881e"]
  subnet_id              = "subnet-0333eac2ae9a804b3"

  
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
