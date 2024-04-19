resource "aws_appflow_flow" "this" {
  name     = "${module.naming.resource_prefix.app_flow}"
  provider = aws.provider2

  source_flow_config {
    connector_type = "S3"
    source_connector_properties {
      s3 {
        bucket_name   = aws_s3_bucket.this.bucket
        bucket_prefix = "source"
      }
    }
  }

  destination_flow_config {
    connector_type = "S3"
    destination_connector_properties {
      s3 {
        bucket_name = aws_s3_bucket.this.bucket
        bucket_prefix = "destination"

        s3_output_format_config {
          file_type = "JSON"
        }
      }
    }
  }

  task {
    source_fields     = ["title1"]
    task_type         = "Map"
    destination_field = "title1"
    connector_operator {
      s3 = "NO_OP"
    }

  }

  trigger_config {
    trigger_type = "OnDemand"
  }
}

# s3
resource "aws_s3_bucket" "this" {
  bucket = "394-bucket-${random_integer.this.result}-green"
  force_destroy = true
}

resource "random_integer" "this" {
  min = 1
  max = 10000000
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "this" {
  depends_on = [aws_s3_bucket_ownership_controls.this]

  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

resource "aws_s3_object" "this" {
  bucket = aws_s3_bucket.this.id
  key    = "source/394-bucket-file.csv"
  source = "394-bucket-file.csv"
}

resource "aws_s3_object" "this2" {
  bucket = aws_s3_bucket.this.id
  key    = "destination/"
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = <<EOF
{
    "Statement": [
        {
            "Effect": "Allow",
            "Sid": "AllowAppFlowSourceActions",
            "Principal": {
                "Service": "appflow.amazonaws.com"
            },
            "Action": [
                "s3:ListBucket",
                "s3:GetObject",
                "s3:PutObject",
                "s3:AbortMultipartUpload",
                "s3:ListMultipartUploadParts",
                "s3:ListBucketMultipartUploads",
                "s3:GetBucketAcl",
                "s3:PutObjectAcl"
            ],
            "Resource": [
                "${aws_s3_bucket.this.arn}",
                "${aws_s3_bucket.this.arn}/*"
            ]
        }
    ],
    "Version": "2012-10-17"
}
EOF
}