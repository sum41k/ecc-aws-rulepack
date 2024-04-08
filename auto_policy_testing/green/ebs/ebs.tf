# ecc-aws-022-ebs_volumes_too_old_snapshots
# ecc-aws-378-ebs_without_tag_information
# ecc-aws-379-ebs_snapshot_without_tag_information
# ecc-aws-548-ebs_volumes_are_of_type_gp3_instead_of_gp2
resource "aws_ebs_volume" "volume_without_encrypt" {
  availability_zone = data.aws_availability_zones.this.names[0]
  size              = 8

  tags = {
    Name = "${module.naming.resource_prefix.ebs}"
  }
}


# ecc-aws-076-ebs_snapshots_not_publicly_restorable
resource "aws_ebs_snapshot" "ebs_snapshot_without_encrypt" {
  volume_id = aws_ebs_volume.volume_without_encrypt.id
}


# ecc-aws-147-ebs_volume_without_encrypt
resource "aws_ebs_volume" "volume_encrypted" {
  availability_zone = data.aws_availability_zones.this.names[0]
  size              = 5
  encrypted         = true
  
  tags = {
    Name = "${module.naming.resource_prefix.ebs}"
  }
}


# ecc-aws-326-ebs_volume_encrypted_with_kms_cmk
resource "aws_kms_key" "encrypt_and_decrypt_volume_kms_key" {
  description             = "Key to encrypt and decrypt EBS Volume"
  key_usage               = "ENCRYPT_DECRYPT"
  policy                  = data.aws_iam_policy_document.this.json
  deletion_window_in_days = 7
  is_enabled              = true
  enable_key_rotation     = true
}

resource "aws_kms_alias" "encrypt_and_decrypt_volume_kms_alias" {
  name          = "alias/326-green"
  target_key_id = aws_kms_key.encrypt_and_decrypt_volume_kms_key.key_id
}

resource "aws_ebs_volume" "volume_encrypted_with_kms_cmk" {
  availability_zone = data.aws_availability_zones.this.names[0]
  size              = 5
  encrypted         = true
  kms_key_id        = aws_kms_key.encrypt_and_decrypt_volume_kms_key.arn
  
  tags = {
    Name = "${module.naming.resource_prefix.ebs}"
  }
}


# ecc-aws-327-ebs_snapshot_encrypted
resource "aws_ebs_encryption_by_default" "this" {
  enabled = true
}


# ecc-aws-328-unused_ebs_volumes
resource "aws_instance" "ec2_instance_to_test_unused_ebs_volumes" {
  ami               = data.aws_ami.this.id
  instance_type     = "t2.nano"
  availability_zone = data.aws_availability_zones.this.names[0]
}

resource "aws_volume_attachment" "this" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.volume_without_encrypt.id
  instance_id = aws_instance.ec2_instance_to_test_unused_ebs_volumes.id
}


# ecc-aws-570-ebs_volumes_are_of_type_gp3_instead_of_io1
resource "aws_ebs_volume" "volume_without_encrypt_gp3_type" {
  availability_zone = data.aws_availability_zones.this.names[0]
  size              = 8
  type              = "gp3"

  tags = {
    Name = "${module.naming.resource_prefix.ebs}"
  }
}


# # ecc-aws-575-ebs_volumes_attached_to_stopped_ec2_instances
# resource "aws_instance" "this" {
#   ami           = data.aws_ami.this.id
#   instance_type = "t2.micro"
#   subnet_id     = data.aws_subnets.this.ids[0]
#   tags = {
#     Name = "575_instance_green"
#   }
# }

# data "aws_ami" "this" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm*"]
#   }
# }

# data "aws_vpc" "default" {
#   default = true
# }

# data "aws_subnets" "this" {
#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.default.id]
#   }
# }
