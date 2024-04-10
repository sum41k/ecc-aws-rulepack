output "ebs" {
  value = {
    ebs_volume = aws_ebs_volume.volume_without_encrypt.id
    ebs_snapshot = aws_ebs_snapshot.ebs_snapshot_without_encrypt.id
    ecc-aws-326-ebs_volume_encrypted_with_kms_cmk = aws_ebs_volume.volume_encrypted_with_kms_cmk.id
  }
}
