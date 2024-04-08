output "ebs" {
  value = {
    ecc-aws-022-ebs_volumes_too_old_snapshots = aws_ebs_volume.volume_without_encrypt.id
    ecc-aws-378-ebs_without_tag_information   = aws_ebs_volume.volume_without_encrypt.id
    ecc-aws-379-ebs_snapshot_without_tag_information = aws_ebs_volume.volume_without_encrypt.id
    ecc-aws-548-ebs_volumes_are_of_type_gp3_instead_of_gp2 = aws_ebs_volume.volume_without_encrypt.id

    ecc-aws-076-ebs_snapshots_not_publicly_restorable = aws_ebs_snapshot.ebs_snapshot_without_encrypt.id

    ecc-aws-147-ebs_volume_without_encrypt = aws_ebs_volume.volume_encrypted.id

    ecc-aws-570-ebs_volumes_are_of_type_gp3_instead_of_io1 = aws_ebs_volume.volume_without_encrypt_gp3_type.id
    ecc-aws-326-ebs_volume_encrypted_with_kms_cmk = aws_ebs_volume.volume_encrypted_with_kms_cmk.id
  }
}
