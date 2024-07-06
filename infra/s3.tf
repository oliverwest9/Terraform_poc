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
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.front_end_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.front_end_bucket.bucket
  key    = "index.html"
  source = "${path.root}/front_end/index.html"
}

resource "aws_s3_bucket_object" "error" {
  bucket = aws_s3_bucket.front_end_bucket.bucket
  key    = "error.html"
  source = "${path.root}/front_end/error.html"
}
