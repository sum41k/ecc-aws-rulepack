resource "aws_iam_group" "this" {
  name = module.naming.resource_prefix.iam_group
  path = "/"
}
