resource "aws_s3_bucket" "front_end_bucket" {
  bucket = var.bucket_name
  

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Name = "StaticWebsite"
  }
}

resource "aws_s3_bucket_policy" "static_website_policy" {
  bucket = aws_s3_bucket.front_end_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          AWS = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
        },
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.front_end_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.front_end_bucket.bucket
  key    = "index.html"
  source = "${path.root}/index.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "error" {
  bucket = aws_s3_bucket.front_end_bucket.bucket
  key    = "error.html"
  source = "${path.root}/error.html"
  content_type = "text/html"
}
