resource "aws_glacier_vault" "this" {
  name = "${module.naming.resource_prefix.glacier}"

  access_policy = <<EOF
{
    "Version":"2012-10-17",
    "Statement":[
       {
          "Sid": "${module.naming.resource_prefix.glacier}",
          "Principal": {
            "AWS": 
            [ 
              "arn:aws:iam::${data.aws_caller_identity.this.account_id}:root"
            ]
          },
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
