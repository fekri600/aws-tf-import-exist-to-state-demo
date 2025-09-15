#!/usr/bin/env bash
set -euo pipefail

terraform import module.imported.aws_s3_bucket.drift_demo_bucket_3238 "drift-demo-bucket-3238"