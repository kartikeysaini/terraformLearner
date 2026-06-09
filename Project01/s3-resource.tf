resource "random_id" "bucket-id" {
  byte_length = 4
}


resource "aws_s3_bucket" "staticwebsite" {
  bucket = "this-is-my-second-bucket-${random_id.bucket-id.hex}"

}

resource "aws_s3_bucket_public_access_block" "static_website" {
  bucket                  = aws_s3_bucket.staticwebsite.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "static_website_public_read" {
  bucket = aws_s3_bucket.staticwebsite.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.staticwebsite.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "staticwebsite" {
  bucket = aws_s3_bucket.staticwebsite.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}


resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.staticwebsite.id
  key          = "index.html"
  source       = "build/index.html"
  etag         = filemd5("build/index.html")
  content_type = "text/html"

}

resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.staticwebsite.id
  key          = "error.html"
  source       = "build/error.html"
  etag         = filemd5("build/error.html")
  content_type = "text/html"

}

