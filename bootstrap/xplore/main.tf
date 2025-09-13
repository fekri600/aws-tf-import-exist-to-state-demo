# IAM policy for Resource Explorer 2 permissions
resource "aws_iam_policy" "resource_explorer2_policy" {
  name        = "ResourceExplorer2Policy"
  description = "Policy for Resource Explorer 2 operations"

  policy = file("${path.module}/resource-explorer-policy.json")
}

# Attach the policy to the terraform_user
resource "aws_iam_user_policy_attachment" "terraform_user_resource_explorer2" {
  user       = "terraform_user"
  policy_arn = aws_iam_policy.resource_explorer2_policy.arn
}

# Enable an LOCAL index in your home region
resource "aws_resourceexplorer2_index" "main" {
  type = "LOCAL"


  depends_on = [aws_iam_user_policy_attachment.terraform_user_resource_explorer2]
}

# Create a default view (all resources)
resource "aws_resourceexplorer2_view" "all" {
  name = "all-resources"

  # Set this as the default view
  default_view = true

  # No filters = show all resources
  depends_on = [aws_iam_user_policy_attachment.terraform_user_resource_explorer2]
}
