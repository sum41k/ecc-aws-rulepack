resource "aws_instance" "this" {
  ami           = data.aws_ami.this.id
  instance_type = "t1.micro"

  metadata_options {
    http_tokens = "optional"
    http_endpoint = "enabled"
  }
  
  tags = {
    Name             = "549_instance_red"
    CustodianRule    = "ecc-aws-549-ec2_instance_previous_generation"
    ComplianceStatus = "Red"
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
