locals {
  # Flatten service actions for all services
  service_actions = flatten([
    for service in var.services : [
      "${service}:Get*",
      "${service}:List*",
      "${service}:Describe*"
    ]
  ])

  list_actions = flatten([
    for service in var.services : [
      "${service}:List*",
      "${service}:Describe*"
    ]
  ])

  # Combine service actions with extra actions
  all_actions = concat(local.service_actions, var.extra_actions)

  is_instance_profile = var.kind == "role" && var.assume_role_service == "ec2.amazonaws.com" ? true : false
  is_role             = var.kind == "role" ? true : false
  is_user             = var.kind == "user" ? true : false
  is_group            = var.kind == "group" ? true : false
}
