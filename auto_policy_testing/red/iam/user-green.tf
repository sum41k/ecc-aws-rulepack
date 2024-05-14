# Created because AWS IAM credentials report can be generated only once per 4 hours.
# This way ensures that whether green or red terraform deployed first the report will have both users. 
# There won't be necessary to wait 4 hour difference to see red user in the report.
# For policies:
# ecc-aws-001-ensure_mfa_is_enabled_for_all_iam_users_with_console_password
# ecc-aws-002-ensure_access_keys_are_rotated_every_90_days
# ecc-aws-017-credentials_unused_for_45_days
# ecc-aws-140-only_one_active_access_key_available_for_any_single_iam_user
# ecc-aws-514-inactive_iam_access_keys_are_not_deleted


resource "aws_iam_user" "green" {
  name          = "autotest_iam_user_green"
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "green" {
  user = aws_iam_user.green.name
}

resource "aws_iam_policy" "this" {
  name        = module.naming.resource_prefix.iam_policy
  description = "ensure mfa is enabled"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:CreateVirtualMFADevice",
        "iam:ListMFADevices",
        "iam:GetAccountPasswordPolicy",
        "iam:ChangePassword"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "green" {
  user       = aws_iam_user.green.name
  policy_arn = aws_iam_policy.this.arn
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