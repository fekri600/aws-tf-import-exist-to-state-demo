#!/usr/bin/env bash
set -euo pipefail

terraform import module.imported.aws_s3_bucket.drift_demo_bucket_5152 "drift-demo-bucket-5152"