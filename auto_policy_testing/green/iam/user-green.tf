resource "aws_iam_user" "green" {
  name          = "autotest_iam_user_green"
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "green" {
  user = aws_iam_user.green.name
}

# ecc-aws-001-ensure_mfa_is_enabled_for_all_iam_users_with_console_password
resource "aws_iam_virtual_mfa_device" "this" {
  virtual_mfa_device_name = "${module.naming.resource_prefix.iam_user}-mfa_device"
}

resource "null_resource" "generate_mfa_tokens" {
  triggers = {
    mfa_string = aws_iam_virtual_mfa_device.this.base_32_string_seed
    user       = aws_iam_user.green.name
    mfa_arn    = aws_iam_virtual_mfa_device.this.id
  }
  provisioner "local-exec" {
    command     = <<EOF
auth_code1=$(oathtool --base32 --totp ${self.triggers.mfa_string})
sleep 30
auth_code2=$(oathtool --base32 --totp ${self.triggers.mfa_string})
aws iam enable-mfa-device --user-name ${self.triggers.user} --serial-number ${self.triggers.mfa_arn} --authentication-code1 $auth_code1 --authentication-code2 $auth_code2
EOF
    interpreter = ["/bin/bash", "-c"]
    quiet       = true
  }

  provisioner "local-exec" {
    when        = destroy
    command     = <<EOF
aws iam deactivate-mfa-device --user-name ${self.triggers.user} --serial-number ${self.triggers.mfa_arn}
aws iam delete-virtual-mfa-device --serial-number ${self.triggers.mfa_arn}
EOF
    interpreter = ["/bin/bash", "-c"]
    quiet       = true
  }

  depends_on = [aws_iam_virtual_mfa_device.this]
}

# ecc-aws-002-ensure_access_keys_are_rotated_every_90_days
# ecc-aws-017-credentials_unused_for_45_days
resource "aws_iam_access_key" "green" {
  user = aws_iam_user.green.name
}


resource "aws_iam_user" "green2" {
  name          = "autotest_iam_user_green2"
  path          = "/"
  force_destroy = true
}

# ecc-aws-017-credentials_unused_for_45_days
resource "aws_iam_access_key" "green2" {
  user = aws_iam_user.green2.name
}

resource "null_resource" "login_via_access_keys" {
  triggers = {
    access_key = sensitive(aws_iam_access_key.green2.id)
    secret_key = sensitive(aws_iam_access_key.green2.secret)
  }
  provisioner "local-exec" {
    environment = {
      AWS_ACCESS_KEY_ID     = self.triggers.access_key
      AWS_SECRET_ACCESS_KEY = self.triggers.secret_key
    }
    command     = <<EOF
aws sts get-caller-identity
aws s3 ls
sleep 60
EOF
    interpreter = ["/bin/bash", "-c"]
    quiet       = true
  }

  depends_on = [aws_iam_access_key.green2]
}

resource "aws_iam_user" "green3" {
  name          = "autotest_iam_user_green3"
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_policy_attachment" "green3" {
  user       = aws_iam_user.green3.name
  policy_arn = aws_iam_policy.this.arn
}
