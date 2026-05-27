provider "tfe" {
  hostname     = var.tfe_hostname
  organization = var.tfe_organization
}

resource "tfe_oauth_client" "bitbucket" {
  organization        = var.tfe_organization
  name                = var.oauth_client_name
  api_url             = var.bitbucket_api_url
  http_url            = var.bitbucket_http_url
  key                 = var.bitbucket_oauth_consumer_key
  secret              = var.bitbucket_oauth_secret
  rsa_public_key      = var.bitbucket_rsa_public_key
  service_provider    = var.bitbucket_service_provider
  organization_scoped = true
}

resource "tfe_ssh_key" "bitbucket" {
  organization = var.tfe_organization
  name         = var.ssh_key_name
  key          = var.bitbucket_ssh_private_key
}

resource "tfe_workspace" "example" {
  organization          = var.tfe_organization
  name                  = var.workspace_name
  description           = var.workspace_description
  auto_apply            = var.workspace_auto_apply
  queue_all_runs        = true
  speculative_enabled   = true
  file_triggers_enabled = false
  terraform_version     = var.workspace_terraform_version
  working_directory     = var.workspace_working_directory
  ssh_key_id            = tfe_ssh_key.bitbucket.id

  vcs_repo {
    identifier     = var.repository_identifier
    branch         = var.repository_branch
    oauth_token_id = tfe_oauth_client.bitbucket.oauth_token_id
  }
}
