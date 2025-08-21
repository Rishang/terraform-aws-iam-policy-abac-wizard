output "role_arn" {
  description = "ARN of the IAM role"
  value       = local.is_role ? aws_iam_role.role[0].arn : null
}

output "role_name" {
  description = "Name of the IAM role"
  value       = local.is_role ? aws_iam_role.role[0].name : null
}

output "instance_profile_name" {
  description = "Name of the IAM instance profile"
  value       = local.is_instance_profile ? aws_iam_instance_profile.profile[0].name : null
}

output "instance_profile_arn" {
  description = "ARN of the IAM instance profile"
  value       = local.is_instance_profile ? aws_iam_instance_profile.profile[0].arn : null
}

output "policy_arn" {
  description = "ARN of the service read policy"
  value       = aws_iam_policy.service_read_policy.arn
}

output "user_arn" {
  description = "ARN of the IAM user"
  value       = local.is_user ? aws_iam_user.user[0].arn : null
}

output "user_name" {
  description = "Name of the IAM user"
  value       = local.is_user ? aws_iam_user.user[0].name : null
}

output "group_arn" {
  description = "ARN of the IAM group"
  value       = local.is_group ? aws_iam_group.group[0].arn : null
}

output "group_name" {
  description = "Name of the IAM group"
  value       = local.is_group ? aws_iam_group.group[0].name : null
}
