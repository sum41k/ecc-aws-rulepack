data "aws_iam_policy" "this" {
  arn = "arn:aws:iam::aws:policy/AWSCloudShellFullAccess"
}

resource "aws_iam_role" "this" {
  name = "872_role_red"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = "${aws_iam_role.this.name}"
  policy_arn = "${data.aws_iam_policy.this.arn}"
}