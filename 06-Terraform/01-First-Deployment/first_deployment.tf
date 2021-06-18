# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
  #access_key = "my-access-key"
  #secret_key = "my-secret-key"
}

resource "aws_instance" "web" {
  ami           = "ami-0d563aeddd4be7fff"
  instance_type = "t2.micro"

  tags = {
    Name = "MyFirstTFNode"
  }
}
