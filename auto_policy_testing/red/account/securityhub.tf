resource "null_resource" "disable_securityhub" {

  provisioner "local-exec" {
    command = <<EOF
set +e
output=$(aws securityhub disable-security-hub 2>&1)
exit_status=$?
if [ "$exit_status" -eq 254 ] && [ "$(echo "$output" | grep 'is not subscribed to Security Hub')" ]; then 
  exit_status=0 
fi
exit $exit_status
EOF
  }
}
