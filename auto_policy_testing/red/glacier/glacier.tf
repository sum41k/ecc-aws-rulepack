resource "aws_glacier_vault" "this" {
  name     = "${module.naming.resource_prefix.glacier}"
  provider = aws.provider2

  access_policy = <<EOF
{
    "Version":"2012-10-17",
    "Statement":[
       {
          "Sid": "${module.naming.resource_prefix.glacier}",
          "Principal": "*",
          "Effect": "Allow",
          "Action": [
             "glacier:ListVaults"
          ],
          "Resource": "arn:aws:glacier:us-east-1:${data.aws_caller_identity.this.account_id}:vaults/${module.naming.resource_prefix.glacier}"
       }
    ]
}
EOF
}
