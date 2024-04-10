output "ebs" {
  value = {
    ebs_volume = aws_ebs_volume.default_volume.id
    ebs_snapshots = aws_ebs_snapshot.snapshot_from_default_volume.id
    ecc-aws-570-ebs_volumes_are_of_type_gp3_instead_of_io1 = aws_ebs_volume.default_io1_volume.id
  }
}
