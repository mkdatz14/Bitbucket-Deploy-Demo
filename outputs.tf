output "oauth_client_id" {
  description = "ID of the Bitbucket OAuth client in HCP Terraform."
  value       = tfe_oauth_client.bitbucket.id
}

output "oauth_token_id" {
  description = "OAuth token ID to reuse in additional workspaces or registry resources."
  value       = tfe_oauth_client.bitbucket.oauth_token_id
}

output "ssh_key_id" {
  description = "ID of the SSH key stored in HCP Terraform for repository cloning."
  value       = tfe_ssh_key.bitbucket.id
}

output "workspace_id" {
  description = "ID of the example HCP Terraform workspace."
  value       = tfe_workspace.example.id
}

output "workspace_html_url" {
  description = "Browser URL for the example HCP Terraform workspace."
  value       = tfe_workspace.example.html_url
}