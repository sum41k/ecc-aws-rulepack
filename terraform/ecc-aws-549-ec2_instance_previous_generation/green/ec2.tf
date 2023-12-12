resource "aws_instance" "this" {
  ami           = data.aws_ami.this.id
  instance_type = "t2.micro"

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  
  tags = {
    Name             = "549_instance_green"
    CustodianRule    = "ecc-aws-549-ec2_instance_previous_generation"
    ComplianceStatus = "Green"
  }
}

data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name = "name"
	values = ["amzn2-ami-hvm*"]
  }
}
