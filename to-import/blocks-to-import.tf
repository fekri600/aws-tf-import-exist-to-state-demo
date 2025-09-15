resource "aws_iam_role" "AWSServiceRoleForAmazonEKS" {
  # Imported from arn:aws:iam::490004637046:role/AWSServiceRoleForAmazonEKS
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}

resource "aws_iam_role" "AWSServiceRoleForElastiCache" {
  # Imported from arn:aws:iam::490004637046:role/AWSServiceRoleForElastiCache
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}

resource "aws_iam_role" "AWSServiceRoleForSupport" {
  # Imported from arn:aws:iam::490004637046:role/AWSServiceRoleForSupport
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}

resource "aws_iam_role" "AWSServiceRoleForElasticLoadBalancing" {
  # Imported from arn:aws:iam::490004637046:role/AWSServiceRoleForElasticLoadBalancing
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}

resource "aws_iam_role" "AWSServiceRoleForTrustedAdvisor" {
  # Imported from arn:aws:iam::490004637046:role/AWSServiceRoleForTrustedAdvisor
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}

resource "aws_iam_role" "AWSServiceRoleForAutoScaling" {
  # Imported from arn:aws:iam::490004637046:role/AWSServiceRoleForAutoScaling
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}

resource "aws_iam_role" "AWSServiceRoleForRDS" {
  # Imported from arn:aws:iam::490004637046:role/AWSServiceRoleForRDS
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}

resource "aws_iam_role" "AWSServiceRoleForOrganizations" {
  # Imported from arn:aws:iam::490004637046:role/AWSServiceRoleForOrganizations
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}

resource "aws_iam_role" "AWSServiceRoleForSSO" {
  # Imported from arn:aws:iam::490004637046:role/AWSServiceRoleForSSO
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}

resource "aws_iam_role" "AWSServiceRoleForAmazonEKSNodegroup" {
  # Imported from arn:aws:iam::490004637046:role/AWSServiceRoleForAmazonEKSNodegroup
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}

resource "aws_s3_bucket" "drift_demo_bucket_3238" {
  # Imported from arn:aws:s3:::drift-demo-bucket-3238
  bucket = "drift-demo-bucket-3238"

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }
}