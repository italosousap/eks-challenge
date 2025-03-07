resource "aws_s3_bucket" "loki_bucket" {
  bucket = "loki-bucket-challenge"
}

resource "aws_s3_bucket" "loki_bucket_chunks" {
  bucket = "loki-chunks-challenge"
}