resource "aws_ami" "this" {
  name                = "${module.naming.resource_prefix.ami}"
  root_device_name    = "/dev/xvda"
  provider            = aws.provider2
  
  ebs_block_device {
    device_name = "/dev/xvda"
    snapshot_id = aws_ebs_snapshot.this.id
    volume_size = 10
  }
}

resource "aws_ebs_volume" "this" {
  availability_zone = data.aws_availability_zones.this.names[0]
  size              = 10
}

resource "aws_ebs_snapshot" "this" {
  volume_id = aws_ebs_volume.this.id
}

resource "aws_ami_launch_permission" "this" {
  image_id = aws_ami.this.id
  group    = "all"
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.this.id
  instance_type = "t2.micro"

  tags = {
    Name = "${module.naming.resource_prefix.ami}"
  }
}

resource "aws_ami_from_instance" "this" {
  name               = "${module.naming.resource_prefix.ami}_from_instance"
  source_instance_id = aws_instance.this.id
  depends_on         = [aws_instance.this]
}