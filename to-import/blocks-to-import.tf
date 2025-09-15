resource "aws_s3_bucket" "drift_demo_bucket_3238" {
  # Imported from arn:aws:s3:::drift-demo-bucket-3238
  bucket = "drift-demo-bucket-3238"

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}