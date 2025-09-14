terraform {
  backend "s3" {
    bucket         = "aws-tf-import-exist-to-state-demo-state-59f8fd06"
    key            = "envs/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
    encrypt        = true
  }
}
