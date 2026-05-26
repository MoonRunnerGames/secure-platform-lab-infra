output "resource_group_name" {
  value       = local.resource_group_name
  description = "The resource group used by the infrastructure deployment."
}

output "location" {
  value       = local.location
  description = "The Azure region used by the infrastructure deployment."
}