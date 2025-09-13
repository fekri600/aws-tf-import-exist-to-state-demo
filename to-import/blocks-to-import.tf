resource "aws_cloudwatch_log_group" "_aws_lambda_i2508dr_prod_1st_lambda_snapshot" {
  # Imported from arn:aws:logs:us-east-1:490004637046:log-group:/aws/lambda/i2508dr-prod-1st-lambda-snapshot
  name = "-aws-lambda-i2508dr-prod-1st-lambda-snapshot"

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}

resource "aws_launch_template" "lt_029ac354b86d0e6b1" {
  # Imported from arn:aws:ec2:us-east-1:490004637046:launch-template/lt-029ac354b86d0e6b1
  name = "lt-029ac354b86d0e6b1"

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}

resource "aws_dynamodb_table" "backend_d_db_table" {
  # Imported from arn:aws:dynamodb:us-east-1:490004637046:table/backend-d-db-table
  name = "backend-d-db-table"

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}

resource "aws_s3_bucket" "drift_demo_bucket_3808" {
  # Imported from arn:aws:s3:::drift-demo-bucket-3808
  name = "drift-demo-bucket-3808"

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}

resource "aws_lb_target_group" "tg_2EC2_ALB_test" {
  # Imported from arn:aws:elasticloadbalancing:us-east-1:490004637046:targetgroup/2EC2-ALB-test/ec1c201e161f403c
  name = "tg-2EC2-ALB-test"

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}