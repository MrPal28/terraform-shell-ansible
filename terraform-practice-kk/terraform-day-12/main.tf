resource "aws_s3_bucket" "datacenter_bucket" {
  bucket = "datacenter-s3-308387793"
}

resource "aws_s3_bucket_ownership_controls" "datacenter_bucket" {
  bucket = aws_s3_bucket.datacenter_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "datacenter_bucket" {
  bucket                  = aws_s3_bucket.datacenter_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "datacenter_bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.datacenter_bucket,
    aws_s3_bucket_public_access_block.datacenter_bucket
  ]

  bucket = aws_s3_bucket.datacenter_bucket.id
  acl    = "public-read"
}

