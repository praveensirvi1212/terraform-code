resource "aws_s3_bucket" "b" {
  bucket = "praveen-sirvi-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
