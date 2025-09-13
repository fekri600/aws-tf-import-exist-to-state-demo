#!/usr/bin/env bash
set -euo pipefail

terraform import module.imported.aws_cloudwatch_log_group._aws_lambda_i2508dr_prod_1st_lambda_snapshot "/aws/lambda/i2508dr-prod-1st-lambda-snapshot"
terraform import module.imported.aws_launch_template.lt_029ac354b86d0e6b1 "lt-029ac354b86d0e6b1"
terraform import module.imported.aws_dynamodb_table.backend_d_db_table "backend-d-db-table"
terraform import module.imported.aws_s3_bucket.drift_demo_bucket_3808 "drift-demo-bucket-3808"
terraform import module.imported.aws_lb_target_group.tg_2EC2_ALB_test "arn:aws:elasticloadbalancing:us-east-1:490004637046:targetgroup/2EC2-ALB-test/ec1c201e161f403c"