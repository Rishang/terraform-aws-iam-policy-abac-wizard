# IAM Group
resource "aws_iam_group" "group" {
  count = local.is_group ? 1 : 0
  name  = var.name
  path  = "/"
}

# Attach the service read policy to the group
resource "aws_iam_group_policy_attachment" "service_read_policy_attach" {
  count      = local.is_group ? 1 : 0
  group      = aws_iam_group.group[0].name
  policy_arn = aws_iam_policy.service_read_policy.arn
}

# Attach additional policies if provided
resource "aws_iam_group_policy_attachment" "additional_policies" {
  count      = local.is_group ? length(var.additional_policies) : 0
  group      = aws_iam_group.group[0].name
  policy_arn = var.additional_policies[count.index]
}
