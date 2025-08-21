
# IAM Role
resource "aws_iam_role" "role" {
  count = local.is_role ? 1 : 0
  name  = var.name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = var.assume_role_service
        }
      },
    ]
  })

  permissions_boundary = var.permissions_boundary

  tags = {
    Name = var.name
  }
}

# Attach the service read policy
resource "aws_iam_role_policy_attachment" "service_read_policy_attach" {
  count      = local.is_role ? 1 : 0
  role       = aws_iam_role.role[0].name
  policy_arn = aws_iam_policy.service_read_policy.arn
}

# Attach additional policies if provided
resource "aws_iam_role_policy_attachment" "additional_policies" {
  count      = local.is_role ? length(var.additional_policies) : 0
  role       = aws_iam_role.role[0].name
  policy_arn = var.additional_policies[count.index]
}

# Instance Profile for EC2
resource "aws_iam_instance_profile" "profile" {
  count = local.is_instance_profile ? 1 : 0
  name  = "${var.name}-ec2-profile"
  role  = aws_iam_role.role[0].name
}
