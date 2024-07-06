resource "aws_s3_bucket" "static_website" {
  bucket = "your-unique-bucket-name"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Name = "StaticWebsite"
  }
}

resource "aws_s3_bucket_policy" "static_website_policy" {
  bucket = aws_s3_bucket.static_website.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.static_website.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.static_website.bucket
  key    = "index.html"
  source = "path/to/your/index.html"
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "error" {
  bucket = aws_s3_bucket.static_website.bucket
  key    = "error.html"
  source = "path/to/your/error.html"
  acl    = "public-read"
}
