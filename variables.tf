variable "kind" {
  type    = string
  default = "role"
  validation {
    condition     = can(regex("^(role|user|group)$", var.kind))
    error_message = "The 'kind' variable must be either 'role' or 'user' or 'group'"
  }
  description = "The kind of IAM role (e.g., 'role', 'user', 'group')"
}

variable "name" {
  type        = string
  description = "Name prefix for IAM resources"
}

variable "services" {
  type        = list(string)
  description = "List of AWS service names for IAM policy permissions (e.g., ['s3', 'ssm', 'ec2'])"
  default     = []
}

variable "extra_actions" {
  type        = list(string)
  description = "List of extra actions to allow eg: ['ssm:GetParameter']"
  default     = []
}

variable "resource_access_tags" {
  type        = map(string)
  description = "Tags used for resource-based access control in IAM policies"
}

variable "assume_role_service" {
  type        = string
  description = "AWS service that can assume this role"
  default     = "ec2.amazonaws.com"
}

variable "additional_policies" {
  type        = list(string)
  description = "List of additional policy ARNs to attach to the role"
  default     = []
}

variable "permissions_boundary" {
  type        = string
  description = "ARN of the permissions boundary policy to attach to the role or user"
  default     = null
  nullable    = true

  validation {
    condition     = var.permissions_boundary == null || (var.kind == "role" || var.kind == "user")
    error_message = "The 'permissions_boundary' variable is only supported for 'role' and 'user' kinds"
  }
}
