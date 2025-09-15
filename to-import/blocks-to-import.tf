resource "aws_s3_bucket" "drift_demo_bucket_5152" {
  # Imported from arn:aws:s3:::drift-demo-bucket-5152
  name = "drift-demo-bucket-5152"

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}