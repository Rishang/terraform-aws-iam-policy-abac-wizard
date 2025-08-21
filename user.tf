# IAM User
resource "aws_iam_user" "user" {
  count                = local.is_user ? 1 : 0
  name                 = var.name
  path                 = "/"
  permissions_boundary = var.permissions_boundary

  tags = {
    Name = var.name
  }
}

# Attach the service read policy to the user
resource "aws_iam_user_policy_attachment" "service_read_policy_attach" {
  count      = local.is_user ? 1 : 0
  user       = aws_iam_user.user[0].name
  policy_arn = aws_iam_policy.service_read_policy.arn
}

# Attach additional policies if provided
resource "aws_iam_user_policy_attachment" "additional_policies" {
  count      = local.is_user ? length(var.additional_policies) : 0
  user       = aws_iam_user.user[0].name
  policy_arn = var.additional_policies[count.index]
}
