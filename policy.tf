# IAM Policy Document for service access
data "aws_iam_policy_document" "service_read_policy" {
  statement {
    effect    = "Allow"
    actions   = local.all_actions
    resources = ["*"]

    dynamic "condition" {
      for_each = var.resource_access_tags
      content {
        test     = "StringEquals"
        variable = "aws:ResourceTag/${condition.key}"
        values   = [condition.value]
      }
    }
  }

  # Allow listing without resource constraints (needed for discovery)
  statement {
    effect    = "Allow"
    actions   = local.list_actions
    resources = ["*"]
  }
}

# IAM Policy
resource "aws_iam_policy" "service_read_policy" {
  name        = "${var.name}-resource"
  description = "Policy allowing read-only access to ${join(", ", var.services)} services based on resource tags"
  policy      = data.aws_iam_policy_document.service_read_policy.json

  tags = {
    Name = "${var.name}-resource"
  }
}
