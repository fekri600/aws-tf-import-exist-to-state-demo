resource "aws_ssm_parameter" "i2508dr_db_db_password" {
  # Imported from arn:aws:ssm:us-east-1:490004637046:parameter/i2508dr/db/db_password

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_cloudwatch_log_group" "_aws_lambda_i2508dr_prod_1st_lambda_snapshot" {
  # Imported from arn:aws:logs:us-east-1:490004637046:log-group:/aws/lambda/i2508dr-prod-1st-lambda-snapshot

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_launch_template" "lt_029ac354b86d0e6b1" {
  # Imported from arn:aws:ec2:us-east-1:490004637046:launch-template/lt-029ac354b86d0e6b1

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_dynamodb_table" "backend_d_db_table" {
  # Imported from arn:aws:dynamodb:us-east-1:490004637046:table/backend-d-db-table

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_ssm_parameter" "i2508dr_ci_rds_snapshot_s3_key" {
  # Imported from arn:aws:ssm:us-east-1:490004637046:parameter/i2508dr/ci/rds_snapshot_s3_key

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_ssm_parameter" "i2508dr_ci_rds_snapshot_code_hash" {
  # Imported from arn:aws:ssm:us-east-1:490004637046:parameter/i2508dr/ci/rds_snapshot_code_hash

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_ssm_parameter" "i2508_oidc_github_trust_role_arn" {
  # Imported from arn:aws:ssm:us-east-1:490004637046:parameter/i2508/oidc/github_trust_role_arn

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_db_parameter_group" "default_mysql8_0" {
  # Imported from arn:aws:rds:us-east-1:490004637046:pg:default.mysql8.0

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_ssm_parameter" "fekri600_aws_tf_inventory_import_oidc_gt_tr_rl_arn" {
  # Imported from arn:aws:ssm:us-east-1:490004637046:parameter/fekri600/aws-tf-inventory-import/oidc/gt-tr-rl-arn

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_db_snapshot" "arn_aws_rds_us_east_1_490004637046_snapshot_rds_i360moms_staging_snapshot" {
  # Imported from arn:aws:rds:us-east-1:490004637046:snapshot:rds-i360moms-staging-snapshot

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_s3_bucket" "drift_demo_bucket_b8a7" {
  # Imported from arn:aws:s3:::drift-demo-bucket-b8a7

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_db_option_group" "default_mysql_8_0" {
  # Imported from arn:aws:rds:us-east-1:490004637046:og:default:mysql-8-0

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_ssm_parameter" "i2508dr_ci_artifacts_bucket_arn" {
  # Imported from arn:aws:ssm:us-east-1:490004637046:parameter/i2508dr/ci/artifacts_bucket_arn

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_ssm_parameter" "i2508dr_ci_rds_failover_s3_key" {
  # Imported from arn:aws:ssm:us-east-1:490004637046:parameter/i2508dr/ci/rds_failover_s3_key

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_ce_anomaly_monitor" "00d9cd68_34ed_458c_849b_48769982278a" {
  # Imported from arn:aws:ce::490004637046:anomalymonitor/00d9cd68-34ed-458c-849b-48769982278a

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_lb_target_group" "arn_aws_elasticloadbalancing_us_east_1_490004637046_targetgroup_2EC2_ALB_test_ec1c201e161f403c" {
  # Imported from arn:aws:elasticloadbalancing:us-east-1:490004637046:targetgroup/2EC2-ALB-test/ec1c201e161f403c

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_ssm_parameter" "i2508dr_db_db_username" {
  # Imported from arn:aws:ssm:us-east-1:490004637046:parameter/i2508dr/db/db_username

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_ssm_parameter" "i2508dr_ci_artifacts_bucket_name" {
  # Imported from arn:aws:ssm:us-east-1:490004637046:parameter/i2508dr/ci/artifacts_bucket_name

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_key_pair" "key_0b5f923543687c353" {
  # Imported from arn:aws:ec2:us-east-1:490004637046:key-pair/key-0b5f923543687c353

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_ssm_parameter" "i2508dr_ci_rds_failover_code_hash" {
  # Imported from arn:aws:ssm:us-east-1:490004637046:parameter/i2508dr/ci/rds_failover_code_hash

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}