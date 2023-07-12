resource "aws_s3_bucket" "this" {
  bucket        = "bucket-968-red"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_s3_bucket_policy" "deny" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.deny.json

  depends_on = [
    aws_s3_bucket_policy.this,
    aws_s3_bucket.this,
    aws_cloudtrail.this
  ]
}
